class AddProductIdToHits < ActiveRecord::Migration[5.2]
  def change
    add_reference :hits, :product, foreign_key: true
  end
end
