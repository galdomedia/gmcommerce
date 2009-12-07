class Order < ActiveRecord::Base
  include AASM

  STATUSES = %w{temporary ordered paid sent delivered canceled}
  belongs_to :shipment
  has_and_belongs_to_many :contacts
  has_many :payments
  has_many :order_items
  has_many :items, :class_name => "order_item", :foreign_key => "order_id"
  
  
  validates_associated :contacts
  validate :validates_contacts_number
  
  before_create :generate_secret
  before_create :generate_number, :if=>proc{|o| o['number'].blank? }
  after_create :fill_in_contact_data, :if=>proc{ |o| o['first_name'].blank? or o['last_name'].blank? or o['email'].blank? or o['phone'].blank? }


  attr_accessor :same_address
  attr_accessible :number, :comment, :shipment_id, :contacts_ids, :contacts_attributes, :shipment_cost, :order_value, :same_address, :order_items_attributes
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
    transitions :to => :paid, :from => [:ordered, :paid]
  end

  aasm_event :send_order do
    transitions :to => :sent, :from => [:paid]
  end

  aasm_event :deliver do
    transitions :to=>:delivered, :from => [:sent, :paid]
  end

  aasm_event :make_canceled do
    transitions :to => :canceled, :from => [:temporary, :ordered, :paid, :sent, :delivered]
  end


  def self.generate_number
    Order.maximum('number') + 1
  end

  def generate_secret
    self.secret = PasswordGenerator::random_pronouncable_password(4)
  end
  
  def generate_number
    self.number = Order.generate_number
  end
  
  def fill_in_contact_data
    c = self.billing_contact
    self.first_name = c.first_name
    self.last_name = c.last_name
    self.email = c.email
    self.phone = c.phone
    self.save
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
        if item.product.is_a? Product
          oi.product = item.product
          oi.product_variation = item.product_variation
        elsif item.product.is_a? ProductSet
          oi.product_set = item.product
        end
        oi.price = item.product_price
        oi.quantity = item.quantity
        oi.discount_value = item.discount_value
        oi.order = order
        oi.save
      end
      order.first_name = order.billing_contact.first_name
      order.last_name = order.billing_contact.last_name
      order.email = order.billing_contact.email
      order.phone = order.billing_contact.phone
      order.save
    end
  end

  def validates_contacts_number
    unless [1,2].member?(self.contacts.length)
       return self.errors.add_to_base('Invalid number of contact_data')
    end
    if self.contacts.length>0
      shipping_present = false
      billing_present = false
      self.contacts.each do |c|
        billing_present = true if c.is_billing
        shipping_present = true if c.is_shipping
        return if (shipping_present and billing_present)
      end
      if not shipping_present or not billing_present
        self.errors.add_to_base('Shipping address missing') unless shipping_present
        self.errors.add_to_base('Billing address missing') unless billing_present
      end
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
