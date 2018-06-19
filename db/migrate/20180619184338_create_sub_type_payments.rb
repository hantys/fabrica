class CreateSubTypePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_type_payments do |t|
      t.string :name
      t.references :type_of_payment, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :sub_type_payments, :deleted_at
  end
end
