class Composition < ApplicationRecord
  enum kind: {raw_material: 0, composition: 1}
  # enum kind: [ :raw_material, :composition ]

  has_many :compositionals, foreign_key: "raw_material", dependent: :destroy
  has_many :sub_compositionals, class_name: "Compositional", foreign_key: "parent_id", dependent: :destroy
  has_many :raw_materials, through: :compositionals
  has_many :sub_compositions, through: :sub_compositionals

  accepts_nested_attributes_for :compositionals, allow_destroy: true

  validates :kind, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { :case_sensitive => false }
  validates :compositionals, presence: true

  def kind_raw_material?
    kind == 0
  end

  def kind_composition?
    kind == 1
  end

end
