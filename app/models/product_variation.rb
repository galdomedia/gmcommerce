class ProductVariation < ActiveRecord::Base


  default_scope :include=>[:options], :order=>['options.position']
  
  has_and_belongs_to_many :options
  belongs_to :product
  belongs_to :option


  validates_numericality_of :price, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>false

  def to_s
    s = self.options.map{|o| "#{o.option_group.name}: #{o.name}"}
    s.join ", "
  end
  
  def options_code_str
    self.options.map{|o| "#{o.code}"}.join ", "
  end
  
  def options_name_str
    self.options.map{|o| "#{o.name}"}.join ", "
  end
end
