class Bank < ApplicationRecord
  acts_as_paranoid

  has_many :op_transactions

  has_paper_trail

  validates :name, presence: true
  validates :ag, presence: true
  validates :cc, presence: true

  
end
