class ProductCustom < ApplicationRecord
  acts_as_paranoid

  belongs_to :product, -> { with_deleted }
  belongs_to :client, -> { with_deleted }

  has_paper_trail

  validates_uniqueness_of :product_id, scope: :client_id

  validates :value, presence: true
  validates :value, numericality: { greater_than: 0 }
end
