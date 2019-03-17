# frozen_string_literal: true

class Budget < ApplicationRecord
  acts_as_paranoid

  enum status: { waiting: 0, rejected: 1, authorized: 2, billed:  3, delivered: 4, confirm: 5 }

  belongs_to :user
  belongs_to :client, -> { with_deleted }
  belongs_to :employee, -> { with_deleted }
  belongs_to :delivery_option, -> { with_deleted }, optional: true
  belongs_to :sub_delivery_option, -> { with_deleted }, optional: true
  belongs_to :type_of_payment, -> { with_deleted }, optional: true
  belongs_to :sub_type_payment, -> { with_deleted }, optional: true
  has_many :budget_products, dependent: :destroy
  has_many :out_of_stocks, dependent: :destroy

  accepts_nested_attributes_for :budget_products, allow_destroy: true
  accepts_nested_attributes_for :out_of_stocks, allow_destroy: true

  has_paper_trail ignore: %i[cod_name updated_at created_at id cod]

  after_save :set_value
  after_save :set_discount
  after_create :set_cod_name
  before_update :verify_value_with_discount
  before_save :verify_status

  validates :value, presence: true
  validates :deadline, presence: true
  # validates :name, presence: true

  validates :value, numericality: { greater_than: 0 }

  def stock_withdrawal(user_id)
    ActiveRecord::Base.transaction do
      budget_products.each do |item|
        product = item.product
        OutOfStock.transaction do
          OutOfStock.create!(budget_id: item.budget_id, budget_product_id: item.id, product_id: item.product_id, user_id: user_id.to_i, qnt: item.qnt, value: item.value_discount_total)
        end
        product.update reserve: product.reserve - item.reserve
      end
      update status: 'delivered'
    end
  rescue Exception => e
    puts e
    false
  end

  def reserve_all
    ActiveRecord::Base.transaction do
      if reserve
        budget_products.each do |budget_product|
          budget_product.update reserve_qnt: 0
        end
        update reserve: false
      else
        budget_products.each do |budget_product|
          budget_product.update reserve_qnt: budget_product.qnt
        end
        update reserve: true
      end
    end
    true
  rescue Exception => e
    false
  end

  def billed_budget
    ActiveRecord::Base.transaction do
      products_for_update = []
      flag_update = true
      budget_products.each do |item|
        item.update reserve: item.qnt
        product = item.product
        free_billed = 0
        reserve_aux = 0
        if item.reserve_qnt > 0
          free_billed = (product.qnt_free + item.reserve_qnt) - item.reserve
          reserve_aux = item.reserve - item.reserve_qnt
          products_for_update << [product.id, reserve_aux]
        else
          free_billed = product.qnt_free - item.reserve
          products_for_update << [product.id, item.reserve]
        end
        if free_billed < 0
          flag_update = false
          break
        end
        # puts "************#{product.name}*************"
        # puts "reserva_qnt #{item.reserve_qnt}"
        # puts "reserva aux #{reserve_aux}"
        # puts "reserva #{item.reserve}"
        # puts "livre #{free_billed}"
        # puts "flag #{flag_update}"
        # puts "products_for_update #{products_for_update}"
      end
      if flag_update
        products_for_update.each do |single|
          product = Product.find single[0]
          reserve = single[1]
          product.update! reserve: product.reserve + reserve
          # puts "flag #{reserve}"
        end
        update! status: 'billed'
      else
        return false
      end
    end
  rescue Exception => e
    puts e
    false
  end

  private

  def verify_status
    case status
    when 'rejected'
      self.rejected_date = Date.today if rejected_date.nil?
    when 'authorized'
      touch(:created_at) if authorized_date.nil?
      self.authorized_date = Date.today if authorized_date.nil?
    when 'billed'
      self.billed_date = Date.today if billed_date.nil?
    when 'delivered'
      self.delivered_date = Date.today if delivered_date.nil?
    when 'confirm'
      self.confirm_date = Date.today if confirm_date.nil?
    end
  end

  def set_cod_name
    b = Budget.find id
    b.update cod_name: "#{b.cod}/#{Date.today.year}"
  end

  def verify_value_with_discount
    if (discount.to_f == 0) && (discount_items.to_f == 0)
      self.value_with_discount = value
      self.discount_items = 0
    end
  end

  def set_discount
    descount_total = budget_products.sum(:total_value_with_discount).round(2)
    if descount_total != discount_items
      if descount_total.to_f > 0
        update discount_items: descount_total.to_f.round(2), value_with_discount: (value.round(2) - descount_total.to_f.round(2)).round(2)
      elsif discount.to_f > 0
        if discount_type
          update discount_items: 0, value_with_discount: (value.to_f.round(2) - ((value.round(2) * discount.to_f.round(2)) / 100)).round(2)
        else
          update discount_items: 0, value_with_discount: (value.to_f.round(2) - discount.to_f.round(2)).round(2)
        end
      else
        if (discount_items.to_f != 0) && (descount_total == 0)
          update discount_items: 0
        end
      end
    end
  end

  def set_value
    unless value.round(2) == budget_products.sum(:total_value).round(2)
      update value: budget_products.sum(:total_value).round(2)
    end
  end
end
