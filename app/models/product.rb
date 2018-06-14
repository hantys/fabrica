class Product < ApplicationRecord
  acts_as_paranoid

  has_paper_trail

  validates :price, numericality: { greater_than: 0 }
  validates :name, presence: true
  validates :cod, presence: true
  validates :price, presence: true


end
