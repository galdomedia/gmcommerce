class ProductTemplate < ActiveRecord::Base

  has_and_belongs_to_many :property_types

  validates_presence_of :template_name
  validates_numericality_of :price, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>true
  validates_length_of :meta_description, :within=>0..255, :allow_nil=>true, :allow_blank=>true
  validates_length_of :meta_keywords, :within=>0..255, :allow_nil=>true, :allow_blank=>true


  attr_accessible :template_name, :name, :sku, :description, :price, :meta_keywords, :meta_description, :property_type_ids
  accepts_nested_attributes_for :property_types
end
