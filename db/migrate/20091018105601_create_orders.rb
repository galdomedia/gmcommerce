class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :number
      t.string :secret
      t.string :status
      t.text :comment
      t.float :order_value
      t.float :shipment_cost
      t.references :shipment
      t.timestamps
    end
    create_table :contacts_orders, :id=>false do |t|
      t.references :order
      t.references :contact
    end
  end
  
  def self.down
    drop_table :contacts_orders
    drop_table :orders
  end
end
