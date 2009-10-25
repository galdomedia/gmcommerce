class AddIdentifierToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :identifier, :string
  end

  def self.down
    remove_column :pages, :identifier
  end
end
