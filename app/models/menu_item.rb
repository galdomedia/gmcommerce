class MenuItem < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :menu_group
  
  validates_presence_of :name
  validates_presence_of :menu_group_id, :on => :create, :message => "can't be blank"
  validates_presence_of :url, :if=>proc{|mi| mi['page_id'].blank?}
  validates_presence_of :page_id, :if=>proc{|mi| mi['url'].blank?}
  
  attr_accessible :name, :url, :page, :menu_group, :page_id, :menu_group_id, :is_outgoing
  
  
  def to_s
    self.name
  end
end
