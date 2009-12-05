class OrderItem < ActiveRecord::Base
  include CalculatedItem
  
  belongs_to :order
  belongs_to :product
  belongs_to :product_variation
  
  validates_presence_of :product_id
  validates_presence_of :price
  validates_presence_of :order_id
  
  
  def price
    return self.attributes['price']
  end
  
end
