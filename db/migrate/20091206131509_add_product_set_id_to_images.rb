class AddProductSetIdToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :product_set_id, :integer
  end

  def self.down
    remove_column :images, :product_set_id
  end
end
