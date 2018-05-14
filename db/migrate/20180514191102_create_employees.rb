class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :cpf
      t.string :email
      t.string :office
      t.string :bank
      t.string :ag
      t.string :cc
      t.string :variation
      t.string :street
      t.string :number
      t.string :string
      t.string :neighborhood
      t.string :cep
      t.references :state, foreign_key: true
      t.references :city, foreign_key: true
      t.string :phone1
      t.string :phone2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
