class AddNewFieldsToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :email, :string
    add_column :contacts, :phone, :string
    add_column :contacts, :is_company, :boolean, :default=>false
    add_column :contacts, :company_name, :string
    add_column :contacts, :vat_code, :string
  end

  def self.down
    remove_column :contacts, :phone
    remove_column :contacts, :email
    remove_column :contacts, :vat_code
    remove_column :contacts, :company_name
    remove_column :contacts, :is_company
  end
end
