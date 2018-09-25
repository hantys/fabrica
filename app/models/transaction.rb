class Transaction < ApplicationRecord
  acts_as_paranoid

  belongs_to :bank
  belongs_to :transactionable, polymorphic: true
  
  has_paper_trail
end
