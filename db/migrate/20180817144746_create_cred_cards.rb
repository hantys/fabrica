class CreateCredCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cred_cards do |t|
      t.string :name
      t.integer :catd_final
      t.string :valid

      t.timestamps
    end
  end
end
