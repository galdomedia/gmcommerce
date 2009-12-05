class GiftDiscount < ActiveRecord::Base


  validates_presence_of :name
  validates_numericality_of :discount_value, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>false
  validates_numericality_of :from_cart_value, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>false

  attr_accessible :name, :discount_value, :from_cart_value, :discounted_products_number, :only_for_products_that_gives_gifts


  def self.get_discount_for_cart_value(cart_value)
    GiftDiscount.find(:all, :conditions=>['from_cart_value < ? and discount_value > ? and only_for_products_that_gives_gifts=?', cart_value, 0, false]).sum{|gd| gd.discount_value}.to_f
  end
  
  def self.get_discounted_products_number_for_cart_value(cart_value)
    # TODO: this looks buggy
    GiftDiscount.find(:all, :conditions=>['from_cart_value < ? and discounted_products_number > ? and only_for_products_that_gives_gifts=?', cart_value, 0, false]).sum{|g| g.discounted_products_number}
  end
  
  def self.get_number_of_gifts_for_cart_value(cart_value, multiplier)
    num = GiftDiscount.find(:all, :conditions=>['only_for_products_that_gives_gifts=? and from_cart_value<? and discounted_products_number>?', true, cart_value, 0]).sum{|g| g.discounted_products_number}
    num*multiplier
  end
  
  def to_s
    self.name
  end
  
end
