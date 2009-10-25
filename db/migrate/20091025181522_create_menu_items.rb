class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string :name
      t.string :url
      t.references :page
      t.references :menu_group
      t.boolean :is_outgoing, :default=>false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :menu_items
  end
end
