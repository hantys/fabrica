class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.string :name
      t.references :client, foreign_key: true
      t.references :employee, foreign_key: true
      t.float :value, default: 0
      t.float :value_with_discount, default: 0
      t.date :deadline
      t.integer :delivery_options
      t.integer :payment_term
      t.integer :type_of_payment
      t.float :discount, default: 0
      t.boolean :discount_type, default: false

      t.timestamps
    end
  end
end
