class AddIsActiveToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :is_active, :boolean, :default=>true
  end

  def self.down
    remove_column :pages, :is_active
  end
end
