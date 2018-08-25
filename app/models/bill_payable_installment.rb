class BillPayableInstallment < ApplicationRecord
  acts_as_paranoid

  enum type_payment: { billet: 0, bank: 1, card: 2 }

  mount_uploader :file, FilesUploader

  belongs_to :bank, -> { with_deleted }, optional: true
  belongs_to :cred_card, -> { with_deleted }, optional: true
  belongs_to :bill_payable, -> { with_deleted }, touch: true, optional: true

  has_paper_trail

  validates :value, presence: true
  validates :value, numericality: { greater_than: 0 }
  validates :date, presence: true
end
