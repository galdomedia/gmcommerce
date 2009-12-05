class WishListItem < ActiveRecord::Base
  attr_accessible :product, :user

  belongs_to :user
  belongs_to :product

  validates_presence_of :user_id
  validates_presence_of :product_id
end
