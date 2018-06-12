class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.string :cod_name
      t.integer :cod
      t.references :client, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :user, foreign_key: true
      t.float :value, default: 0
      t.float :discount_items, default: 0
      t.float :value_with_discount, default: 0
      t.date :deadline
      t.integer :delivery_options
      t.integer :payment_term
      t.integer :type_of_payment
      t.float :discount, default: 0
      t.boolean :discount_type, default: false

      t.timestamps
    end

    execute <<-SQL
     CREATE SEQUENCE cod_seq START 400;
     ALTER SEQUENCE cod_seq OWNED BY budgets.cod;
     ALTER TABLE budgets ALTER COLUMN cod SET DEFAULT nextval('cod_seq');
    SQL
  end
end
