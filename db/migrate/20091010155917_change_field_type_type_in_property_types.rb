class ChangeFieldTypeTypeInPropertyTypes < ActiveRecord::Migration
  def self.up
    remove_column :property_types, :field_type
    add_column :property_types, :field_type, :string
  end

  def self.down
    remove_column :property_types, :field_type
    add_column :property_types, :field_type, :integer
  end
end
