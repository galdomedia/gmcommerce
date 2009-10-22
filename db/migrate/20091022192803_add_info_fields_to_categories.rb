class AddInfoFieldsToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :description, :text
    add_column :categories, :short_description, :text
    add_column :categories, :icon_file_name, :string
    add_column :categories, :icon_file_size, :integer
    add_column :categories, :icon_content_type, :string
  end

  def self.down
    remove_column :categories, :icon_content_type
    remove_column :categories, :icon_file_size
    remove_column :categories, :icon_file_name
    remove_column :categories, :short_description
    remove_column :categories, :description
  end
end
