class AddPositionToPropertyTypes < ActiveRecord::Migration
  def self.up
    add_column :property_types, :position, :integer, :default=>1000
  end

  def self.down
    remove_column :property_types, :position, :default=>1000
  end
end
