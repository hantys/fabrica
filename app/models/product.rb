class Product < ApplicationRecord
  acts_as_paranoid

  before_create :set_round_price

  has_many :hits
  has_many :stock_final_products
  has_many :item_product_stocks

  has_paper_trail

  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :name, presence: true
  validates :name, uniqueness: { :case_sensitive => false }
  validates :cod, presence: true
  validates :cod, uniqueness: { :case_sensitive => false }

  def set_round_price
    self.price = self.price.round(2)
  end


end
