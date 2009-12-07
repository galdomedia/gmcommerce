class Property < ActiveRecord::Base

  belongs_to :product
  belongs_to :property_type

  has_attached_file :attachment
  
  #validates_presence_of :product_id
  #validates_presence_of :property_type_id
end
