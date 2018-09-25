class OpTransaction < ApplicationRecord
  acts_as_paranoid

  enum type_action: { credit: 0, debit: 1 }
  enum action: { transfer: 0, paid: 1, receive: 2 }

  belongs_to :bank
  belongs_to :transactionable, polymorphic: true

  has_paper_trail

  validates :value, numericality: { greater_than_or_equal_to: 0 }

  before_save :check_mod_value
  after_save :update_bank

  private

  def check_mod_value
    if self.type_action == 'debit'
      self.value = self.value * -1
    end
  end

  def update_bank
    bank = self.bank  
    balance = bank.balance  
    bank.update balance: (balance + self.value)
  end
end
