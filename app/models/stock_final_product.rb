class StockFinalProduct < ApplicationRecord
  acts_as_paranoid

  enum kind: {raw_material: 0, product: 1}

  belongs_to :product, optional: true
  belongs_to :derivative, class_name: "Product", :foreign_key => 'derivative_id', optional: true
  belongs_to :hit, optional: true
  has_many :item_product_stocks

  has_paper_trail

  validates :kind, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates_presence_of :product, :if => :product?
  validates_presence_of :derivative, :if => :product?
  validates_presence_of :qnt_out, :if => :product?
  validates :qnt_out, numericality: { greater_than: 0 }, :if => :product?
  # validate :verify_qnt_out, :if => :product?
  validates :weight, numericality: { greater_than: 0 }, :if => :raw_material?
  validates :residue, numericality: { greater_than: 0 }, :if => :raw_material?
  validates_presence_of :hit, :if => :raw_material?

  before_create :save_estimated
  after_create :set_estimated_weight
  after_create :set_cost


  before_create :set_amount_out #seta peso de saida na criação
  # before_destroy :check_routine_trigger #faz o rollback do peso na materia-prima quando a entrada de estoque e deletada
  after_create :update_stock_final_product #atualiza o peso da materia-prima quando tem uma entrada no estoque
  before_save :weight_refresh_trigger #atualiza o peso da materia-prima quando ocorre alguma retirada


  def verify_qnt_out
    if self.kind == 'product'
      begin
        qnt = Product.find(self.derivative_id).qnt
        if self.qnt_out.to_f > qnt.to_f
          errors.add(:qnt_out, "Não pode ser maior que #{qnt}")
        end
      rescue Exception => e
        errors.add(:derivative, "Não pode ser branco")
      end
    end
  end

  def raw_material?
    self.kind == 'raw_material'
  end

  def product?
    self.kind == 'product'
  end

  private
    def set_amount_out
      self.amount_out = self.amount
    end

    def update_stock_final_product
      self.product.update(qnt: self.product.qnt + self.amount)
    end

    def weight_refresh_trigger
      if self.will_save_change_to_attribute?(:amount_out)
        self.product.update(qnt: self.product.qnt - (self.amount_out_change_to_be_saved[0]-self.amount_out_change_to_be_saved[1]))
      end
    end

    def save_estimated
      if self.kind == "raw_material"
        hit = Hit.find self.hit_id
        self.product_id = hit.product_id
        hit.hit_items.includes(:raw_material).each do |hit_item|
          stocks = hit_item.raw_material.stock_raw_materials.where('weight_out > 0').order(:id)
          @i = 0
          @weight = hit_item.weight

          while @weight > 0  do
            stock = stocks[@i]
            if @weight <= stock.weight_out
              HitItemStock.create!(stock_raw_material_id: stock.id, hit_item: hit_item, weight: @weight)
              @weight = 0
            else
              rest = @weight - stock.weight_out
              HitItemStock.create!(stock_raw_material_id: stock.id, hit_item: hit_item, weight: (@weight - rest))
              @weight = rest
            end
            @i +=1
          end
        end
        hit.update used: true
      else
        # implementar nada para implementar
      end
    end

    def set_estimated_weight
      if self.kind == "raw_material"
        self.estimated_weight = self.hit.hit_items.sum(:weight)
        self.save!
      end
    end

    def set_cost
      @calc_cost = 0
      if self.kind == "raw_material"
        self.hit.hit_items.includes(:hit_item_stocks).each do |hit_item|
          hit_item.hit_item_stocks.each do |item|
            stock = item.stock_raw_material
            @calc_cost = @calc_cost+((stock.price*item.weight)/stock.weight)
          end
        end
      else
        product = self.product
        product_derivative = self.derivative

        @stocks = product_derivative.stock_final_products.where('amount_out > 0').order(:id)
        @product_stocks = []
        @i = 0
        @qnt = self.qnt_out
        while @qnt > 0  do
          stock = @stocks[@i]
          puts "*******************#{stock.amount_out}"
          if @qnt <= stock.amount_out
            @product_stocks << ItemProductStock.create!(stock_final_product_id: stock.id, product_id: product.id, qnt: @qnt)
            @qnt = 0
          else
            rest = @qnt - stock.amount_out
            @product_stocks << ItemProductStock.create!(stock_final_product_id: stock.id, product_id: product.id, qnt: (@qnt - rest))
            @qnt = rest
          end
          @i +=1
        end

        @product_stocks.each do |item|
          stock = item.stock_final_product
          @calc_cost = @calc_cost+((stock.cost*item.qnt)/stock.amount)
        end
      end
      self.update! cost: @calc_cost
    end
end
