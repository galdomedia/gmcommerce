class Producer < ActiveRecord::Base

  has_many :products

  validates_presence_of :name
  validates_length_of :name, :minimum=>1

  attr_accessible :name  

  def to_s
    self.name
  end

  def to_param
    "#{self.id}-#{self.name ? self.name.parameterize : ''}"
  end
end
