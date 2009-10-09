class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessible :login, :email, :password, :password_confirmation

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
