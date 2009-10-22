class AddInfoFieldsToPropertyTypes < ActiveRecord::Migration
  def self.up
    add_column :property_types, :description, :text
    add_column :property_types, :short_description, :text
    add_column :property_types, :icon_file_name, :string
    add_column :property_types, :icon_file_size, :integer
    add_column :property_types, :icon_content_type, :string
  end

  def self.down
    remove_column :property_types, :icon_content_type
    remove_column :property_types, :icon_file_size
    remove_column :property_types, :icon_file_name
    remove_column :property_types, :short_description
    remove_column :property_types, :description
  end
end
