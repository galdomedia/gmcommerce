class AddContactFieldsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :email, :string
    add_column :orders, :user_id, :integer
  end

  def self.down
    remove_column :orders, :user_id
    remove_column :orders, :email
    remove_column :orders, :phone
    remove_column :orders, :last_name
    remove_column :orders, :first_name
  end
end
