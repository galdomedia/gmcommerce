class Product < ActiveRecord::Base
  belongs_to :producer
  has_and_belongs_to_many :categories
  has_many :images

  named_scope :available, :conditions=>[]

  validates_presence_of :name
  validates_numericality_of :price, :float=>true
  validates_length_of :meta_description, :within=>0..255
  validates_length_of :meta_keywords, :within=>0..255

  attr_accessible :name, :sku, :price, :description, :meta_keywords, :meta_description, :producer_id, :category_ids, :images_attributes
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => proc { |a| a['attachment'].blank? }



  
end
