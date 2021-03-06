class RawMaterial < ApplicationRecord
  acts_as_paranoid

  has_many :compositionals, dependent: :destroy
  has_many :compositions, through: :compositionals
  has_many :hit_item, dependent: :destroy
  has_many :stock_raw_materials, dependent: :destroy

  has_paper_trail

  validates :name, presence: true
  # validates :slug_name, presence: true
  # validates :slug_name, uniqueness: true

  validates :name, uniqueness: { :case_sensitive => false }

  before_save :set_slug_name

  private

    def set_slug_name
      self.slug_name = self.name.parameterize
    end
end

