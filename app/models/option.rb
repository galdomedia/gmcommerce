class Option < ActiveRecord::Base

  belongs_to :option_group
  
  default_scope :order=>['position ASC']
  
  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :scope=>:option_group_id

  attr_accessible :name, :code
end
