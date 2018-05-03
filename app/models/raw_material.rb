class RawMaterial < ApplicationRecord
  has_many :compositional, dependent: :destroy
  has_many :compositions, through: :compositional

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
