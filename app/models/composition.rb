class Composition < ApplicationRecord
  enum kind: {raw_material: 0, composition: 1}
  # enum kind: [ :raw_material, :composition ]

  has_many :compositionals, dependent: :destroy
  has_many :raw_materials, through: :compositionals
  has_many :sub_compositions, class_name: "Composition", foreign_key: "parent_composition_id", dependent: :destroy

  accepts_nested_attributes_for :compositionals, allow_destroy: true
  accepts_nested_attributes_for :sub_compositions, allow_destroy: true

  # belongs_to :father, class_name: "Composition", :foreign_key => 'parent_composition_id', touch: true

  validates :kind, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { :case_sensitive => false }
  validates :raw_materials, presence: true, if: :kind_raw_material?
  validates :sub_compositions, presence: true, if: :kind_composition?

  def kind_raw_material?
    kind == 0
  end

  def kind_composition?
    kind == 1
  end

end
