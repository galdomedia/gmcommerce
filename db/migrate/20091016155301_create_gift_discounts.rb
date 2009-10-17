class CreateGiftDiscounts < ActiveRecord::Migration
  def self.up
    create_table :gift_discounts do |t|
      t.string :name
      t.float :discount_value, :default=>0.0
      t.float :from_cart_value, :default=>0.0
      t.timestamps
    end
  end
  
  def self.down
    drop_table :gift_discounts
  end
end
