class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.string :gateway
      t.string :status
      t.references :order
      t.string :ip
      t.string :transaction_id
      t.text :transaction_status

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
