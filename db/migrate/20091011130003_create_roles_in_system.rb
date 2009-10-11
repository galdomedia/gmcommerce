class CreateRolesInSystem < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :is_staff, :default=>false
    end

    create_table :roles_users, :id=>false do |t|
      t.references :role
      t.references :user
    end
  end

  def self.down
    drop_table :roles_users
    remove_column :users, :is_staff
  end
end
