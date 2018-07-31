class Compositional < ApplicationRecord
  acts_as_paranoid

  belongs_to :raw_material, -> { with_deleted } , touch: true
  belongs_to :composition, -> { with_deleted } , touch: true

  has_paper_trail

  # validates :raw_material_id, presence: true
  # validates :composition_id, presence: true
end
