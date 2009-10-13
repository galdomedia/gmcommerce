class CreateShipments < ActiveRecord::Migration
  def self.up
    create_table :shipments do |t|
      t.string :name
      t.float :cost, :default=>0.0
      t.boolean :active, :default=>true
      t.float :free_from_cart_value, :default=>10000000.0
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :shipments
  end
end
