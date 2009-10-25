class MenuGroup < ActiveRecord::Base
  
  has_many :menu_items
  
  validates_presence_of :name
  validates_uniqueness_of :identifier, :if=>:identifier?
  
  attr_accessible :name, :identifier
  
  
  
  def to_s
    self.name
  end
end
