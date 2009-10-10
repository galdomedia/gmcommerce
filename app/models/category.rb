class Category < ActiveRecord::Base
  acts_as_category
  
  attr_accessible :name, :parent_id
  validates_presence_of :name

  has_and_belongs_to_many :products

  def to_s
    self.name
  end

  def to_param
    "#{self.id}-#{self.name ? self.name.parameterize : ''}"
  end


end
