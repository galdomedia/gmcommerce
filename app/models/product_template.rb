class ProductTemplate < ActiveRecord::Base

  has_and_belongs_to_many :property_types

  validates_presence_of :template_name
  validates_numericality_of :price, :float=>true
  validates_length_of :meta_description, :within=>0..255
  validates_length_of :meta_keywords, :within=>0..255


  attr_accessible :template_name, :name, :sku, :description, :price, :meta_keywords, :meta_description, :property_type_ids
  accepts_nested_attributes_for :property_types
end
