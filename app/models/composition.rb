class Composition < ApplicationRecord
  acts_as_paranoid

  has_many :compositionals, dependent: :destroy
  has_many :raw_materials, through: :compositionals

  accepts_nested_attributes_for :compositionals, allow_destroy: true

  has_paper_trail

  validates :name, presence: true
  validates :name, uniqueness: { :case_sensitive => false }
  validates :compositionals, presence: true

end
