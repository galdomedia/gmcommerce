class CreateWishListItems < ActiveRecord::Migration
  def self.up
    create_table :wish_list_items do |t|
      t.references :product
      t.references :user
      t.timestamps
    end
  end
  
  def self.down
    drop_table :wish_list_items
  end
end
