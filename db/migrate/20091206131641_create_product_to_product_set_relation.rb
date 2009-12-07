class CreateProductToProductSetRelation < ActiveRecord::Migration
  def self.up
    create_table :product_sets_products, :id=>false do |t|
      t.references :product_set
      t.references :product
    end
  end

  def self.down
    drop_table :product_sets_products
  end
end
