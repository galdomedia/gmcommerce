class AddPositionToMenuGroups < ActiveRecord::Migration
  def self.up
    add_column :menu_groups, :position, :integer, :default=>10000
  end

  def self.down
    remove_column :menu_groups, :position
  end
end
