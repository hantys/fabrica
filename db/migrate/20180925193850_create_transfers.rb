class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.references :user, foreign_key: true
      t.references :bank, foreign_key: true
      t.integer :bank_receiver_id, index: true
      t.float :value
      t.text :obs
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
