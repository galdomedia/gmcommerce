class ProductSet < ActiveRecord::Base


  has_and_belongs_to_many :products

  has_many :images, :dependent=>:destroy

  validates_presence_of :name
  validates_numericality_of :price, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>false

  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => proc { |a| a['attachment'].blank? }


  attr_accessible :name, :sku, :price, :short_description, :description, :images_attributes, :product_ids


  def have_variations?
    false
  end

  def product_variations
    nil
  end

  def get_price
    self.price
  end
end
