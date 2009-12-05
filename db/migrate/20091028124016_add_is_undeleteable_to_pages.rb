class AddIsUndeleteableToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :is_undeleteable, :boolean
  end

  def self.down
    remove_column :pages, :is_undeletable
  end
end
