class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :street_nr
      t.string :city
      t.string :zip_code
      t.string :country
      t.boolean :is_billing
      t.boolean :is_shipping
      t.timestamps
    end
  end
  
  def self.down
    drop_table :contacts
  end
end
