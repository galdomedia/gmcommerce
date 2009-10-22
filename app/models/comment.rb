class Comment < ActiveRecord::Base
  
  
  belongs_to :product
  belongs_to :user
  
  validates_presence_of :author, :if=>proc{ |c| c['user_id'].blank? }
  validates_presence_of :comment
  
  before_save :fill_in_author
  
  attr_accessible :author, :comment, :note, :user_id
  
  def fill_in_author
    self.author = self.user.login unless self.user_id.blank?
  end
end
