class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :ag
      t.string :cc
      t.string :op

      t.timestamps
    end
  end
end
