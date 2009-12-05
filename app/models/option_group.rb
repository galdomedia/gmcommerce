class OptionGroup < ActiveRecord::Base

  has_and_belongs_to_many :products
  has_many :options

  validates_presence_of :name

  attr_accessible :name, :options_attributes
  accepts_nested_attributes_for :options, :allow_destroy => true, :reject_if => proc { |o| o['code'].blank? }
  
  def to_s
    self.name
  end
end
