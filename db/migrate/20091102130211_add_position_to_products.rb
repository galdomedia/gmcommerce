class AddPositionToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :position, :integer, :default=>1000
  end

  def self.down
    remove_column :products, :position
  end
end
