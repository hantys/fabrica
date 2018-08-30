class ProviderContract < ApplicationRecord
  acts_as_paranoid

  enum status: { active: 0, finish: 1 }

  before_save :set_status

  belongs_to :provider, -> { with_deleted }
  has_many :item_provider_contracts, dependent: :destroy
  has_many :budget_provider_contracts, dependent: :destroy

  accepts_nested_attributes_for :item_provider_contracts, allow_destroy: true
  accepts_nested_attributes_for :budget_provider_contracts, allow_destroy: true

  has_paper_trail


  validates :total_value, numericality: { greater_than: 0 }
  validates :total_value, presence: true
  validates :name, presence: true

  def set_status
    if self.partil_value.round(2) >= self.total_value.round(2)
      self.status = 1
    else
      self.status = 0
    end

  end
end
