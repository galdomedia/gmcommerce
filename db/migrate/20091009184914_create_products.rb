class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.float :price, :default=>0.0
      t.text :description
      t.string :meta_keywords, :default=>''
      t.string :meta_description, :default=>''
      t.references :producer
      t.timestamps
    end
  end
  
  def self.down
    drop_table :products
  end
end
