class BillPayableInstallment < ApplicationRecord
  acts_as_paranoid

  enum type_payment: { billet: 0, bank: 1, card: 2 }
  enum status: { pending: 0, paid: 1 }
  mount_uploader :file, FilesUploader

  belongs_to :bank, -> { with_deleted }, optional: true
  belongs_to :cred_card, -> { with_deleted }, optional: true
  belongs_to :bill_payable, -> { with_deleted }, touch: true, optional: true
  has_one :transaction, as: :transactionable

  has_paper_trail

  validates :payday, presence: true, if: Proc.new{|item| item.status == 'paid' }
  validates :file, presence: true, if: Proc.new{|item| item.status == 'paid' }
  validates :interest, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{|item| item.status == 'paid' }

  validates :code, length: {is: 55}, if: Proc.new{|item| ((item.billet == false) and item.billet?) }
  validates :code, length: {is: 54}, if: Proc.new{|item| ((item.billet == true) and item.billet?) }
  validates :code, uniqueness: true, allow_nil: true, allow_blank: true, if: Proc.new{|item| (item.billet?) }

  validates :cred_card, presence: true, if: :card?

  validates :bank, presence: true, if: :bank?
  validates :bank_name, presence: true, if: :bank?
  validates :cc, presence: true, if: :bank?
  validates :ag, presence: true, if: :bank?

  validates :value, presence: true
  validates :value, numericality: { greater_than: 0 }
  validates :date, presence: true

  def billet?
    self.type_payment == 'billet'
  end

  def bank?
    self.type_payment == 'bank'
  end

  def card?
    self.type_payment == 'card'
  end
end
