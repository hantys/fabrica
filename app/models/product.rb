class Product < ApplicationRecord
  acts_as_paranoid

  has_many :hits
  has_many :stock_final_products
  has_many :item_product_stocks

  has_paper_trail

  validates :price, numericality: { greater_than: 0 }
  validates :name, presence: true
  validates :cod, presence: true
  validates :price, presence: true

  before_create :set_round_price

  def set_round_price
    self.price = self.price.round(2)
  end


end
