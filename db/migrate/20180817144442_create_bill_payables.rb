class CreateBillPayables < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_payables do |t|
      t.references :provider_contract
      t.integer :status, default: 0
      t.references :category
      t.references :revenue
      t.text :obs
      t.string :file
      t.float :total_value

      t.timestamps
    end
  end
end
