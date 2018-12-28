class Bank < ApplicationRecord
  acts_as_paranoid

  has_many :op_transactions, dependent: :destroy

  accepts_nested_attributes_for :op_transactions, allow_destroy: true

  has_paper_trail

  validates :name, presence: true
  validates :ag, presence: true
  validates :cc, presence: true

  
end
