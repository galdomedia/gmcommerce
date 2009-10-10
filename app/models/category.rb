class Category < ActiveRecord::Base
  acts_as_category

  has_and_belongs_to_many :products

  validates_presence_of :name

  attr_accessible :name, :parent_id




  def to_s
    self.name
  end

  def to_param
    "#{self.id}-#{self.name ? self.name.parameterize : ''}"
  end


end
