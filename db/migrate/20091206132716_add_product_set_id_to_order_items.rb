class AddProductSetIdToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :product_set_id, :integer
  end

  def self.down
    remove_column :order_items, :product_set_id
  end
end
