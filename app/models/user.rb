class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :roles

  attr_accessible :login, :email, :password, :password_confirmation

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def to_s
    self.login
  end
end
