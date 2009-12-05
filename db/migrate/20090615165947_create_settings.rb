class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings, :force => true do |t|
      t.string :label
      t.string :identifier, :null => false
      t.text   :description
      t.string :field_type, :default => 'string', :null => false
      t.text   :value

      t.timestamps
    end
    add_index :settings, :identifier
  end

  def self.down
    remove_index :settings, :identifier
    drop_table :settings
  end
end
