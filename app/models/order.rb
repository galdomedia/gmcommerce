class Order < ActiveRecord::Base
  include AASM

  
  belongs_to :shipment
  has_and_belongs_to_many :contacts
  #has_many :payments
  #has_many :order_items
  
  validates_associated :contacts
  validate :validates_contacts_number
  
  before_create :generate_secret

  attr_accessor :same_address
  attr_accessible :number, :comment, :shipment_id, :contacts_ids, :contacts_attributes, :shipment_cost, :same_address
  accepts_nested_attributes_for :contacts, :allow_destroy => true

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

  def self.create_new(order, cart)
    Order.transaction do
      order.number = Order.generate_number
      order.order_value = cart.total_price_with_gifts_and_discounts
      order.shipment_cost = cart.shipment_cost
      order.shipment = cart.shipment
      order.order
      order.save
      for item in cart.items
        
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
end
