class Product < ActiveRecord::Base

  belongs_to :producer
  has_and_belongs_to_many :categories
  has_many :images 
  has_many :properties
  has_many :property_types, :through => :properties
  

  named_scope :available, :conditions=>[]

  validates_presence_of :name
  validates_numericality_of :price, :float=>true
  validates_length_of :meta_description, :within=>0..255
  validates_length_of :meta_keywords, :within=>0..255

  attr_accessible :name, :sku, :price, :description, :meta_keywords, :meta_description, :producer_id, :category_ids, :images_attributes, :properties_attributes
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => proc { |a| a['attachment'].blank? }
  accepts_nested_attributes_for :properties, :allow_destroy => true


  def fill_values_from_template(template)
    self.name = template.name
    self.price = template.price
    self.description = template.description
    self.meta_description = template.meta_description
    self.meta_keywords = template.meta_keywords
    template.property_types.each do |pt|
      self.properties << Property.new({:property_type_id=>pt.id})
    end
  end
  
end
