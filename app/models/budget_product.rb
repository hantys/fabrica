class BudgetProduct < ApplicationRecord
  acts_as_paranoid

  before_save :set_total_value
  before_save :reserve_product, if: :will_save_change_to_reserve_qnt?

  belongs_to :budget
  belongs_to :product

  has_paper_trail ignore: [:budget_id, :updated_at, :created_at, :id]

  validates :unit_value, presence: true
  validates :total_value, presence: true
  validates :qnt, presence: true
  validates :reserve_qnt, presence: true
  validates :unit_value, numericality: { greater_than: 0 }
  validates :total_value, numericality: { greater_than: 0 }
  validates :qnt, numericality: { greater_than: 0 }
  validates :reserve_qnt, numericality: { greater_than_or_equal_to: 0 }

  def value_discount_total
    total_value - total_value_with_discount
  end

  private
    def reserve_product
      product = self.product
      product.update reserve: ((product.reserve - self.reserve_qnt_change_to_be_saved[0]) + self.reserve_qnt_change_to_be_saved[1])
    end

    def set_total_value
      self.unit_value = Product.find(self.product_id).price.round(2)
      self.total_value = (self.unit_value * self.qnt).round(2)

      if self.discount.to_f > 0
        if self.discount_type
          self.total_value_with_discount = (((self.unit_value.to_f.round(2) * self.discount.to_f.round(2)) / 100) * self.qnt.to_f).round(2)
        else
          self.total_value_with_discount = (self.discount.to_f.round(2) * self.qnt.to_f).round(2)
        end
      else
        self.total_value_with_discount = 0
      end
    end
end