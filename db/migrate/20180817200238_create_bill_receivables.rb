class CreateBillReceivables < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_receivables do |t|
      t.integer :type_receivable
      t.references :budget, foreign_key: true
      t.string :name_other
      t.string :cpf_other
      t.string :cnpj_other
      t.string :phone_other
      t.text :obs_other
      t.references :category, foreign_key: true
      t.references :revenue, foreign_key: true
      t.integer :status
      t.text :obs
      t.string :file
      t.float :total_value

      t.timestamps
    end
  end
end
