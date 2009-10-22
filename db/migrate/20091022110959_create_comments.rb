class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :author
      t.references :user
      t.references :product
      t.text :comment
      t.integer :note
      t.timestamps
    end
  end
  
  def self.down
    drop_table :comments
  end
end
