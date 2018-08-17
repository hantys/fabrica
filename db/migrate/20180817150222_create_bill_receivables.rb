class CreateBillReceivables < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_receivables do |t|
      t.string :type_receivable
      t.references :budget
      t.string :name_other
      t.string :cpf_other
      t.string :cnpj_other
      t.string :phone_other
      t.text :obs_other
      t.references :category
      t.references :revenue
      t.integer :status
      t.text :obs
      t.string :file
      t.float :total_value

      t.timestamps
    end
  end
end
