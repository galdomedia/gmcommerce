class CreateCategoryProductHabtm < ActiveRecord::Migration
  def self.up
    create_table :categories_products, :id=>false do |t|
      t.references :category
      t.references :product
    end
  end

  def self.down
    drop_table :categories_products
  end
end
