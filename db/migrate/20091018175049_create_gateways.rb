class CreateGateways < ActiveRecord::Migration
  def self.up
    create_table :gateways do |t|
      t.string :name
      t.string :ident
      t.boolean :is_active

      t.timestamps
    end
  end

  def self.down
    drop_table :gateways
  end
end
