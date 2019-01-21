class AddTypeResidueToComposition < ActiveRecord::Migration[5.2]
  def change
    add_reference :compositions, :type_residue, foreign_key: {to_table: :raw_materials}, default: 1
  end
end