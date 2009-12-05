class AddGivesGiftsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :gives_gifts, :boolean, :default=>false
  end

  def self.down
    remove_column :products, :gives_gifts
  end
end
