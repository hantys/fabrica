class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.string :name
      t.references :client, foreign_key: true
      t.references :employee, foreign_key: true
      t.float :value
      t.date :deadline
      t.integer :delivery_options
      t.integer :payment_term
      t.integer :type_of_payment
      t.float :discount
      t.boolean :discount_type

      t.timestamps
    end
  end
end
