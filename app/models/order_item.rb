class OrderItem < ActiveRecord::Base
  include CalculatedItem
  
  belongs_to :order
  belongs_to :product
  belongs_to :product_set
  belongs_to :product_variation
  
  validates_presence_of :product_id, :if=>proc{|oi| oi['product_set_id'].blank?}
  validates_presence_of :product_set_id, :if=>proc{|oi| oi['product_id'].blank?}
  validates_presence_of :price
  validates_presence_of :order_id
  
  
  def price
    return self.attributes['price']
  end
  
end
