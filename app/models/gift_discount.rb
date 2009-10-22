class GiftDiscount < ActiveRecord::Base


  validates_presence_of :name
  validates_numericality_of :discount_value, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>false
  validates_numericality_of :from_cart_value, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>false

  attr_accessible :name, :discount_value, :from_cart_value


  def self.get_discount_for_cart_value(cart_value)
    GiftDiscount.find(:all, :conditions=>['from_cart_value<?', cart_value]).sum{|gd| gd.discount_value}.to_f
  end
  
  def to_s
    self.name
  end
  
end
