class Shipment < ActiveRecord::Base

  named_scope :active, :conditions=>['active=?', true]
  
  validates_presence_of :name
  validates_numericality_of :cost, :only_integer=>false, :allow_nil=>true
  validates_numericality_of :free_from_cart_value, :only_integer=>false, :allow_nil=>true

  attr_accessible :name, :cost, :active, :free_from_cart_value, :description


  def to_s
    self.name
  end
end
