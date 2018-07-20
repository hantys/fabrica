class Budget < ApplicationRecord
  acts_as_paranoid

  enum status: { waiting: 0, rejected: 1, authorized: 2, billed: 3, delivered: 4, confirm: 5 }

  belongs_to :user
  belongs_to :client
  belongs_to :employee
  belongs_to :delivery_option, optional: true
  belongs_to :sub_delivery_option, optional: true
  belongs_to :type_of_payment, optional: true
  belongs_to :sub_type_payment, optional: true
  has_many :budget_products, dependent: :destroy
  has_many :out_of_stocks, dependent: :destroy

  accepts_nested_attributes_for :budget_products, allow_destroy: true
  accepts_nested_attributes_for :out_of_stocks, allow_destroy: true

  has_paper_trail ignore: [:cod_name, :updated_at, :created_at, :id, :cod]

  after_save :set_value
  after_save :set_discount
  after_create :set_cod_name
  before_update :verify_value_with_discount


  validates :value, presence: true
  validates :deadline, presence: true
  # validates :name, presence: true

  validates :value, numericality: { greater_than: 0 }

  def stock_withdrawal(user_id)
    begin
      ActiveRecord::Base.transaction do
        self.budget_products.each do |item|
          OutOfStock.transaction do
            OutOfStock.create!(budget_id: item.budget_id, budget_product_id: item.id, product_id: item.product_id, user_id: user_id.to_i, qnt: item.qnt, value: item.value_discount_total)
          end
        end
        self.update status: 'delivered'
      end
    rescue Exception => e
      return false
    end
  end

  #criar metodo de verificar reserva quando faturar

  #criar modo de reserva junto com botao faturar

  private
    def set_cod_name
      b = Budget.find self.id
      b.update cod_name: "#{b.cod}/#{Date.today.year}"
    end

    def verify_value_with_discount
      if self.discount.to_f == 0 and self.discount_items.to_f == 0
        self.value_with_discount = self.value
        self.discount_items = 0
      end
    end

    def set_discount
      descount_total = self.budget_products.sum(:total_value_with_discount).round(2)
      if descount_total != self.discount_items
        if descount_total.to_f > 0
          self.update discount_items: descount_total.to_f.round(2), value_with_discount: (self.value.round(2) - descount_total.to_f.round(2)).round(2)
        elsif self.discount.to_f > 0
          if self.discount_type
            self.update discount_items: 0, value_with_discount: (self.value.to_f.round(2) - ((self.value.round(2) * self.discount.to_f.round(2)) / 100)).round(2)
          else
            self.update discount_items: 0, value_with_discount: (self.value.to_f.round(2) - self.discount.to_f.round(2)).round(2)
          end
        else
          if self.discount_items.to_f != 0 and descount_total == 0
            self.update discount_items: 0
          end
        end
      end
    end

    def set_value
      unless self.value.round(2) == self.budget_products.sum(:total_value).round(2)
        self.update value: self.budget_products.sum(:total_value).round(2)
      end
    end
end
