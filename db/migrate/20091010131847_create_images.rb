class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :attachment_file_name
      t.integer :attachment_file_size
      t.string :attachment_content_type

      t.references :product
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
