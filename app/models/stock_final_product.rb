# frozen_string_literal: true

class StockFinalProduct < ApplicationRecord
  acts_as_paranoid

  attr_accessor :hit_weigth, :derivative_qnt

  enum kind: { raw_material: 0, product: 1 }

  before_create :save_estimated
  before_create :set_amount_out # seta peso de saida na criação
  before_create :set_residue # seta peso de saida na criação

  after_create :set_cost
  after_create :set_estimated_weight
  after_create :calc_residue
  after_create :update_stock_final_product

  before_save :weight_refresh_trigger

  before_destroy :check_routine_trigger

  belongs_to :product, optional: true
  belongs_to :derivative, class_name: 'Product', foreign_key: 'derivative_id', optional: true
  belongs_to :hit, optional: true
  has_many :item_product_stocks, dependent: :destroy

  has_paper_trail

  validates :kind, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates_presence_of :product, if: :product?
  validates_presence_of :derivative, if: :product?
  validates_presence_of :qnt_out, if: :product?
  validates :qnt_out, numericality: { greater_than: 0 }, if: :product?
  validate :verify_qnt_out, if: :product?, on: :create
  validates :weight, numericality: { greater_than: 0 }, if: :raw_material?
  validate :verify_weigth, if: :raw_material?, on: :create
  validates :residue, numericality: { greater_than_or_equal_to: 0 }, if: :raw_material?
  validates_presence_of :hit, if: :raw_material?
  validates_presence_of :residue, if: :raw_material?

  def verify_qnt_out
    if kind == 'product'
      begin
        qnt = Product.find(derivative_id).qnt
        if qnt_out.to_f > qnt.to_f
          errors.add(:qnt_out, "Não pode ser maior que #{qnt}")
          throw(:abort)
        end
      rescue Exception => e
        errors.add(:derivative, 'Não pode ser branco')
      end
    end
  end

  def verify_weigth
    if weight > hit_weigth.to_f
      errors.add(:weight, "Não pode ser maior que #{hit_weigth}")
      throw(:abort)
    end
  end

  def raw_material?
    kind == 'raw_material'
  end

  def product?
    kind == 'product'
  end

  private

  def check_routine_trigger
    if amount != amount_out
      # raise "não pode ser apagado. Já existe uma saida desse material"
      # errors[:base] << "não pode ser apagado. Já existe uma saida desse material"
      # return false
      errors.add :base, 'Não pode ser apagado. Já existe uma saida desse produto'
      false
      # Rails 5
      throw(:abort)
    else
      if kind == 'raw_material'
        hit = self.hit
        hit.update used: false
        hit.hit_items.includes(:raw_material).each do |hit_item|
          hit_item.hit_item_stocks.each do |item|
            stock = item.stock_raw_material
            stock.update(weight_out: item.weight + stock.weight_out)
          end
        end
      else
        product_derivative = derivative

        product_derivative.item_product_stocks.each do |item|
          stock = item.stock_final_product
          stock.update(amount_out: item.qnt + stock.amount_out)
        end
      end
      product.update(qnt: product.qnt - amount)
    end
  end

  def set_residue
    if kind == 'raw_material'
      hit_weigth = Hit.find(hit_id).hit_items.sum(:weight).round(2)
      self.residue = hit_weigth - weight
    end
  end

  def set_amount_out
    self.amount_out = amount
    self.residue = 0 unless residue.present?
  end

  def update_stock_final_product
    product.update(qnt: product.qnt + amount)
  end

  # aqui faz a atualizacao automatica da qnt do produto
  def weight_refresh_trigger
    if will_save_change_to_attribute?(:amount_out)
      product.update!(qnt: product.qnt - (amount_out_change_to_be_saved[0] - amount_out_change_to_be_saved[1]))
    end
  end

  def save_estimated
    if kind == 'raw_material'
      hit = Hit.find hit_id
      self.product_id = hit.product_id
      hit.hit_items.includes(:raw_material).each do |hit_item|
        stocks = hit_item.raw_material.stock_raw_materials.where('weight_out > 0').order(:id)
        @i = 0
        @weight = hit_item.weight

        while @weight > 0
          stock = stocks[@i]
          if @weight <= stock.weight_out
            HitItemStock.create!(stock_raw_material_id: stock.id, hit_item: hit_item, weight: @weight)
            @weight = 0
          else
            rest = @weight - stock.weight_out
            HitItemStock.create!(stock_raw_material_id: stock.id, hit_item: hit_item, weight: (@weight - rest))
            @weight = rest
          end
          @i += 1
        end
      end
      hit.update used: true
    else
      # implementar nada para implementar
    end
  end

  def set_estimated_weight
    if kind == 'raw_material'
      self.estimated_weight = hit.hit_items.sum(:weight)
      save!
    end
  end

  def increment_qnt_product
    if product?
      product = self.product
      product.update!(qnt: product.qnt + qnt)
    end
  end

  def set_cost
    @calc_cost = 0
    if kind == 'raw_material'
      hit.hit_items.includes(:hit_item_stocks).each do |hit_item|
        hit_item.hit_item_stocks.each do |item|
          stock = item.stock_raw_material
          @calc_cost += ((stock.price * item.weight) / stock.weight)
        end
      end
    else
      product = self.product
      product_derivative = derivative

      @stocks = product_derivative.stock_final_products.where('amount_out > 0').order(:id)
      @product_stocks = []
      @i = 0
      @qnt = qnt_out
      while @qnt > 0
        stock = @stocks[@i]
        if @qnt <= stock.amount_out
          @product_stocks << ItemProductStock.create!(stock_final_product_id: stock.id, product_id: product_derivative.id, qnt: @qnt)
          @qnt = 0
        else
          rest = @qnt - stock.amount_out
          @product_stocks << ItemProductStock.create!(stock_final_product_id: stock.id, product_id: product_derivative.id, qnt: (@qnt - rest))
          @qnt = rest
        end
        @i += 1
      end

      @product_stocks.each do |item|
        stock = item.stock_final_product
        @calc_cost += ((stock.cost * item.qnt) / stock.amount)
      end
    end
    update! cost: @calc_cost
  end

  def calc_residue
    if residue.to_f > 0
      raw_material = hit.type_residue
      stock_raw_material = StockRawMaterial.create raw_material: raw_material, weight: residue, price: cost
      # raw_material.update amount: raw_material.amount + self.residue
    end
  end
end
