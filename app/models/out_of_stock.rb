class OutOfStock < ApplicationRecord
  acts_as_paranoid

  after_create :update_qnt_product

  belongs_to :budget
  belongs_to :user
  belongs_to :product

  has_paper_trail

  validates :qnt, presence: true
  validates :value, presence: true

  private

    def update_qnt_product
      product = self.product

      @stocks = product.stock_final_products.where('amount_out > 0').order(:id)
      @product_stocks = []
      @i = 0
      @calc_cost = 0
      @qnt = self.qnt
      while @qnt > 0  do
        stock = @stocks[@i]
        ItemProductStock.transaction do
          if @qnt <= stock.amount_out
            @product_stocks << ItemProductStock.create!(stock_final_product_id: stock.id, product_id: product.id, qnt: @qnt)
            @qnt = 0
          else
            rest = @qnt - stock.amount_out
            @product_stocks << ItemProductStock.create!(stock_final_product_id: stock.id, product_id: product.id, qnt: (@qnt - rest))
            @qnt = rest
          end
        end
        @i +=1
      end

      @product_stocks.each do |item|
        stock = item.stock_final_product
        @calc_cost = @calc_cost+((stock.cost*item.qnt)/stock.amount)
      end
      self.update! cost: @calc_cost
    end

end
