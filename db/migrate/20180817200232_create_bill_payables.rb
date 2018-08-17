class CreateBillPayables < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_payables do |t|
      t.references :provider_contract, foreign_key: true
      t.integer :status
      t.references :category, foreign_key: true
      t.references :revenue, foreign_key: true
      t.text :obs
      t.string :file
      t.float :total_value

      t.timestamps
    end
  end
end
