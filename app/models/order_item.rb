class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :product_variation
  
  validates_presence_of :product_id
  validates_presence_of :price
  validates_presence_of :order_id
end
