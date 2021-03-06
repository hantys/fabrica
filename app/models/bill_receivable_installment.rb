class BillReceivableInstallment < ApplicationRecord
  acts_as_paranoid

  enum status: { pending: 0, paid: 1 }

  mount_uploader :file, FilesUploader
  mount_uploader :file_to_pay, FilesUploader

  before_destroy :check_destroy

  belongs_to :bank, -> { with_deleted }
  belongs_to :bill_receivable, -> { with_deleted }, optional: true, touch: true
  has_many :op_transaction, as: :transactionable

  has_paper_trail

  validates :payday, presence: true, if: Proc.new{|item| item.status == 'paid' }
  # validates :file, presence: true, if: Proc.new{|item| item.status == 'paid' }
  validates :interest, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{|item| item.status == 'paid' }

  validates :value, numericality: { greater_than: 0 }
  validates :bank, presence: true
  validates :date, presence: true

  after_save :new_transaction

  private
  
  def new_transaction
    if self.status == 'paid' and self.op_transaction.blank?
      self.op_transaction.create bank: self.bank, type_action: 0, action: 2, value: (self.value + self.interest), obs: "Recebimento da conta #{self.bill_receivable_id}"
    end
  end

  def check_destroy
    if self.op_transaction.present?
      ActiveRecord::Base.transaction do
        self.op_transaction.destroy_all
      end
    end
  end
end
