class ProductCustom < ApplicationRecord
  acts_as_paranoid

  belongs_to :product, -> { with_deleted }
  belongs_to :client, -> { with_deleted }

  has_paper_trail

  # validates :price, presence: true
end
