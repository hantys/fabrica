class RawMaterial < ApplicationRecord
  has_many :compositional, dependent: :destroy
  has_many :compositions, through: :compositional
end
