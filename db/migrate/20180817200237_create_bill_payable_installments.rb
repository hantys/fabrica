class CreateBillPayableInstallments < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_payable_installments do |t|
      t.references :bank, foreign_key: true
      t.references :cred_card, foreign_key: true
      t.boolean :billet
      t.string :code
      t.string :file
      t.string :date
      t.float :value
      t.integer :status

      t.timestamps
    end
  end
end
