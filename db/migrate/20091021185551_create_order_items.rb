class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.references :order
      t.references :product
      t.references :product_variation
      t.float :price, :default=>0.0
      t.float :quantity, :default=>1

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
