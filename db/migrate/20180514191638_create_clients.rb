class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :company_name
      t.string :fantasy_name
      t.string :cpf
      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :cep
      t.string :cnpj
      t.string :ie
      t.references :state, foreign_key: true
      t.references :city, foreign_key: true
      t.string :phone1
      t.string :phone2
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
