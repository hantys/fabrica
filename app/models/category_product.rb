class CategoryProduct < ApplicationRecord
  acts_as_paranoid

  has_many :products

  has_paper_trail

  validates :name, presence: true
end
