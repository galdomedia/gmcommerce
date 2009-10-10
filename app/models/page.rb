class Page < ActiveRecord::Base

  validates_presence_of :title

  attr_accessible :title, :body

  
end
