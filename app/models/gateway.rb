class Gateway < ActiveRecord::Base

  named_scope :active, :conditions=>['is_active=?', true]
end
