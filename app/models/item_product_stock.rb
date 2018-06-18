class ItemProductStock < ApplicationRecord
  acts_as_paranoid

  belongs_to :product
  belongs_to :derivative, class_name: "Product", :foreign_key => 'derivative_id', optional: true
  belongs_to :stock_final_product

  has_paper_trail

  after_create :update_qnt

  def update_qnt
    stock = self.stock_final_product
    stock.amount_out = stock.amount_out - self.qnt
    stock.save!
  end
end
