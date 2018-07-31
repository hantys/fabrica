class Compositional < ApplicationRecord
  acts_as_paranoid

  belongs_to :raw_material, touch: true, -> { with_deleted }
  belongs_to :composition, touch: true, -> { with_deleted }

  has_paper_trail

  # validates :raw_material_id, presence: true
  # validates :composition_id, presence: true
end
