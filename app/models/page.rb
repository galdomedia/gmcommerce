class Page < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true, :strip_diacritics => true
  
  validates_presence_of :title

  attr_accessible :title, :body, :is_active
  
  def to_s
    self.title
  end
  
end
