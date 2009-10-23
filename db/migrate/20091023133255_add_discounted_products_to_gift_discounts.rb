class AddDiscountedProductsToGiftDiscounts < ActiveRecord::Migration
  def self.up
    add_column :gift_discounts, :discounted_products_number, :integer, :default=>0
  end

  def self.down
    remove_column :gift_discounts, :discounted_products_number
  end
end
