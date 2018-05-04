class Composition < ApplicationRecord
  enum kind: {raw_material: 0, composition: 1}
  # enum kind: [ :raw_material, :composition ]

  has_many :compositionals, dependent: :destroy
  has_many :raw_materials, through: :compositionals
  has_many :sub_compositions, class_name: "Composition", foreign_key: "parent_composition_id", dependent: :destroy

  accepts_nested_attributes_for :compositionals, allow_destroy: true

  # belongs_to :father, class_name: "Composition", :foreign_key => 'parent_composition_id', touch: true

  validates :kind, presence: true
end
