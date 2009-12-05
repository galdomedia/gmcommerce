class AddIsPromotedToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_promoted, :boolean, :default=>false
  end

  def self.down
    remove_column :products, :is_promoted
  end
end
