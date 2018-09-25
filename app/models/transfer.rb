class Transfer < ApplicationRecord
  acts_as_paranoid
  
  before_destroy :check_destroy

  belongs_to :user
  belongs_to :bank
  belongs_to :bank_receiver, class_name: "Bank", foreign_key: "bank_receiver_id"
  has_many :op_transaction, as: :transactionable

  has_paper_trail

  validate :verify_banks
  validates :value, presence: true
  validates :value, numericality: { greater_than: 0 }

  after_create :new_transaction

  private

  def verify_banks
    if self.bank_id == self.bank_receiver_id
      errors.add :bank_receiver_id, "Não ser o mesmo de origem."
      false
      # Rails 5
      throw(:abort)
    end
  end
  
  def new_transaction
    ActiveRecord::Base.transaction do
      self.op_transaction.create bank: self.bank, type_action: 1, action: 0, value: self.value, obs: "Trasferencia para o banco #{self.bank_receiver.name} feita por #{self.user.username}"
      self.op_transaction.create bank: self.bank_receiver, type_action: 0, action: 0, value: self.value, obs: "Trasferencia recebido do banco #{self.bank_receiver.name} feita por #{self.user.username}"
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
