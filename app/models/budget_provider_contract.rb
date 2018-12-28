class BudgetProviderContract < ApplicationRecord
  acts_as_paranoid

  belongs_to :budget, -> { with_deleted }
  belongs_to :provider_contract, -> { with_deleted }, touch: true, optional: true

  has_paper_trail

  validates :value, numericality: { greater_than: 0 }
  validates :value, presence: true
  validates :budget_id, uniqueness: { scope: :provider_contract_id }
  validates :budget_id, presence: true
end
