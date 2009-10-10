class CreateProductTemplates < ActiveRecord::Migration
  def self.up
    create_table :product_templates do |t|
      t.string :template_name
      t.string :name
      t.string :sku
      t.string :description
      t.float :price
      t.string :meta_keywords
      t.string :meta_description
      t.timestamps
    end

    create_table :product_templates_property_types, :id=>false do |t|
      t.references :product_template
      t.references :property_type
    end
  end
  
  def self.down
    drop_table :product_templates_property_types
    drop_table :product_templates
  end
end
