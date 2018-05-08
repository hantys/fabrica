class Compositional < ApplicationRecord
  belongs_to :raw_material, touch: true, optional: true
  belongs_to :composition, touch: true, optional: true
  belongs_to :sub_composition, class_name: "Composition", :foreign_key => 'parent_id', touch: true, optional: true

  # validates :raw_material_id, presence: true
  # validates :composition_id, presence: true
end
