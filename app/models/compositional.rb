class Compositional < ApplicationRecord
  acts_as_paranoid

  belongs_to :raw_material, touch: true, optional: true
  belongs_to :composition, touch: true, optional: true
  belongs_to :sub_composition, class_name: "Composition", :foreign_key => 'parent_id', touch: true, optional: true

  has_paper_trail

  # validates :raw_material_id, presence: true
  # validates :composition_id, presence: true
end
