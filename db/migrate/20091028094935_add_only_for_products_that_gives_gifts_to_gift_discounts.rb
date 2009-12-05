class AddOnlyForProductsThatGivesGiftsToGiftDiscounts < ActiveRecord::Migration
  def self.up
    add_column :gift_discounts, :only_for_products_that_gives_gifts, :boolean, :default=>false
  end

  def self.down
    remove_column :gift_discounts, :only_for_products_that_gives_gifts
  end
end
