class ProviderContract < ApplicationRecord
  acts_as_paranoid

  enum status: { active: 0, finish: 1 }

  before_destroy :check_destroy
  before_save :set_status

  belongs_to :provider, -> { with_deleted }
  has_many :item_provider_contracts, dependent: :destroy
  has_many :budget_provider_contracts, dependent: :destroy
  has_many :bill_payables

  accepts_nested_attributes_for :item_provider_contracts, allow_destroy: true
  accepts_nested_attributes_for :budget_provider_contracts, allow_destroy: true

  has_paper_trail

  validates :total_value, numericality: { greater_than: 0 }
  validates :total_value, presence: true
  validates :name, presence: true
  validate :verify_total
  validates :item_provider_contracts, presence: true

  private
    def verify_total
      value_item = 0
      self.item_provider_contracts.map { |e| value_item = value_item + e.value  }
      self.total_value = value_item
      if value_item < self.partil_value
        errors.add :total_value, "Não pode ser menos que #{self.partil_value}."
        false
        # Rails 5
        throw(:abort)
      end
    end

    def set_status
      if self.partil_value.round(2) >= self.total_value.round(2)
        self.status = 1
      else
        self.status = 0
      end
    end

    def check_destroy
      if self.bill_payables.size > 0
        errors.add :base, "Não pode ser apagado. Existem Contas a pagar associadas a este contrato"
        false
        # Rails 5
        throw(:abort)
      end
    end
end
