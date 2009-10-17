class AddIsGiftToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_gift, :boolean, :default=>false
  end

  def self.down
    remove_column :products, :is_gift
  end
end
