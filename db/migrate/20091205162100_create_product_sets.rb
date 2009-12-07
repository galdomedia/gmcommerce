class CreateProductSets < ActiveRecord::Migration
  def self.up
    create_table :product_sets do |t|
      t.string :name
      t.string :sku
      t.float :price
      t.text :short_description
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :product_sets
  end
end
