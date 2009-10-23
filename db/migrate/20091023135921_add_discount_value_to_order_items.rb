class AddDiscountValueToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :discount_value, :float, :default=>0.0
  end

  def self.down
    remove_column :order_items, :discount_value
  end
end
