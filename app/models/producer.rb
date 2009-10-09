class Producer < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_length_of :name, :minimum=>1

  has_many :products

  def to_s
    self.name
  end

  def to_param
    "#{self.id}-#{self.name ? self.name.parameterize : ''}"
  end
end
