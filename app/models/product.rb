class Product < ActiveRecord::Base
  belongs_to :producer
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :option_groups
  has_many :images, :dependent=>:destroy
  has_many :properties, :dependent=>:destroy
  has_many :property_types, :through => :properties
  has_many :product_variations
  has_many :comments
  

  named_scope :available, :conditions=>['is_gift=?', false]
  named_scope :gifts, :conditions=>['is_gift=?', true]

  validates_presence_of :name
  validates_numericality_of :price, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>false
  validates_length_of :meta_description, :within=>0..255, :allow_nil=>true, :allow_blank=>true
  validates_length_of :meta_keywords, :within=>0..255, :allow_nil=>true, :allow_blank=>true

  attr_accessible :name, :sku, :price, :description, :meta_keywords, :meta_description, :producer_id, :category_ids, :images_attributes, :properties_attributes, :option_group_ids, :product_variations_attributes, :is_gift
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => proc { |a| a['attachment'].blank? }
  accepts_nested_attributes_for :properties, :allow_destroy => true
  accepts_nested_attributes_for :product_variations, :allow_destroy => true, :reject_if => proc { |pv| pv['price'].blank? }
  after_save :check_product_variatons_options


  def to_s
    self.name
  end
  
  def to_param
    unless self.name.blank?
      "#{self.id}-#{self.name.parameterize}"
    else
      self.id
    end
  end
  
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

  def get_minimal_price
    if self.product_variations.length > 0
      prices = self.product_variations.map{|pv| pv.price}
      prices.min
    else
      self.price
    end
  end
  alias_method :get_price, :get_minimal_price

  def get_first_variation
    if self.product_variations.count > 0
      self.product_variations.first
    else
      nil
    end
  end
  
  def get_maximal_price
    if self.product_variations.count > 0
      prices = self.product_variations.map{|pv| pv.price}
      prices.max
    else
      self.price
    end
  end
  
  def get_minimal_variation
    if self.product_variations.count > 0
      self.product_variations.min{|a,b| a.price<=>b.price}
    else
      nil
    end
  end

  def get_maximal_variation
    if self.product_variations.count > 0
      self.product_variations.max{|a,b| a.price<=>b.price}
    else
      nil
    end
  end

  def have_variations?
    not self.product_variations.empty?
  end

  def new_product_variation
    pv = ProductVariation.new
    pv.product = self
    for og in self.option_groups
      o = Option.new
      o.option_group = og
      pv.options << o 
    end
    pv
  end

  def check_product_variatons_options
    og_ids = self.option_groups.map{|og| og.id}
    pv_og_ids = []
    for pv in self.product_variations
      for o in pv.options
        if self.option_groups.member?(o.option_group)
          pv_og_ids << o.option_group_id unless pv_og_ids.member?(o.option_group_id)
        else
          pv.options.delete(o)
        end
      end
      for og_id in (og_ids-pv_og_ids)
        og = self.option_groups.find(og_id)
        pv.options << og.options.first
        pv.save
      end
    end
  end
  
end
