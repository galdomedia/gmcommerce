class Order < ActiveRecord::Base
  include AASM

  
  belongs_to :shipment
  has_and_belongs_to_many :contacts
  #has_many :payments
  has_many :order_items

  validates_associated :contacts
  validate :validates_contacts_number
  
  before_create :generate_secret
  before_create :generate_number, :if=>proc{|o| o['number'].blank? }

  attr_accessor :same_address
  attr_accessible :number, :comment, :shipment_id, :contacts_ids, :contacts_attributes, :shipment_cost, :same_address, :order_items_attributes
  accepts_nested_attributes_for :contacts, :allow_destroy => true
  accepts_nested_attributes_for :order_items, :allow_destroy => true, :reject_if=>proc { |oi| oi['price'].blank? }

  aasm_column :status
  aasm_initial_state :temporary

  aasm_state :temporary
  aasm_state :ordered
  aasm_state :paid
  aasm_state :sent
  aasm_state :delivered
  aasm_state :canceled


  aasm_event :order do
    transitions :to => :ordered, :from => [:temporary]
  end

  aasm_event :pay do
    transitions :to => :paid, :from => [:ordered]
  end

  aasm_event :send_order do
    transitions :to => :sent, :from => [:paid]
  end

  aasm_event :deliver do
    transitions :to=>:delivered, :from => [:sent, :paid]
  end

  aasm_event :cancel do
    transitions :to => :canceled, :from => [:temporary, :ordered, :paid, :sent, :delivered]
  end


  def self.generate_number
    Order.all.length + 1
  end

  def generate_secret
    self.secret = PasswordGenerator::random_pronouncable_password(4)
  end
  
  def generate_number
    self.number = Order.generate_number
  end

  def self.create_new(order, cart)
    Order.transaction do
      order.number = Order.generate_number
      order.order_value = cart.total_price_with_gifts_and_discounts
      order.shipment_cost = cart.shipment_cost
      order.shipment = cart.shipment
      order.order
      order.save
      for item in cart.items
        oi = OrderItem.new
        oi.product = item.product
        oi.product_variation = item.variation
        oi.price = item.product_price
        oi.quantity = item.quantity
        oi.order = order
        oi.save
      end
    end
  end

  def validates_contacts_number
    if self.contacts.length != 2
       self.errors.add_to_base('Invalid number of contact data, should be 2 (billing and shipping)')
    end
  end

  def billing_contact
    self.contacts.find(:first, :conditions=>['is_billing=?', true])

  end

  def shipping_contact
    self.contacts.find(:first, :conditions=>['is_shipping=?', true])
  end
  
  def complete_value
    self.shipping_cost + self.order_value
  end
end
