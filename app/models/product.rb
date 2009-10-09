class Product < ActiveRecord::Base
  attr_accessible :name, :sku, :price, :description, :meta_keywords, :meta_description, :producent_id

  validates_presence_of :name
  validates_numericality_of :price, :float=>true
  validates_length_of :meta_description, :within=>0..255
  validates_length_of :meta_keywords, :within=>0..255

  belongs_to :producer

end
