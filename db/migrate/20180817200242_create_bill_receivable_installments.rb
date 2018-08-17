class CreateBillReceivableInstallments < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_receivable_installments do |t|
      t.references :bank, foreign_key: true
      t.string :file
      t.string :date
      t.float :value
      t.integer :status

      t.timestamps
    end
  end
end
