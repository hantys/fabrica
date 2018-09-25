class OpTransaction < ApplicationRecord
  acts_as_paranoid

  enum type_action: { credit: 0, debit: 1 }
  enum action: { transfer: 0, paid: 1, receive: 2 }
  
  before_destroy :check_destroy

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

  def check_destroy
    begin
      ActiveRecord::Base.transaction do
        bank = self.bank  
        balance = bank.balance
        bank.update balance: (balance - self.value)
      end
    rescue Exception => e
      errors.add :base, "Não pode ser apagado. Ocorreu algum problema"
      false
      # Rails 5
      throw(:abort)
    end
  end
  
end
