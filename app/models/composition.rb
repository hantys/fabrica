class Composition < ApplicationRecord
  has_many :compositional, dependent: :destroy
  has_many :raw_materials, through: :compositional
  has_many :sub_compositions, class_name: "Composition", foreign_key: "parent_composition_id", dependent: :destroy

  belongs_to :parent, class_name: "Composition", :foreign_key => 'parent_composition_id', touch: true
end
