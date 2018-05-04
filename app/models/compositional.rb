class Compositional < ApplicationRecord
  belongs_to :raw_material, touch: true
  belongs_to :composition, touch: true

  validates :raw_material_id, presence: true
  validates :composition_id, presence: true
end
