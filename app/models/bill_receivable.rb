class BillReceivable < ApplicationRecord
  acts_as_paranoid

  enum status: { pending: 0, late: 1, paid: 2 }
  enum type_receivable: { budget: 0, other: 1 }

  mount_uploader :file, FilesUploader

  belongs_to :budget, -> { with_deleted }, optional: true
  belongs_to :category, -> { with_deleted }, optional: true
  belongs_to :revenue, -> { with_deleted }, optional: true

  has_many :bill_receivable_installments, dependent: :destroy

  accepts_nested_attributes_for :bill_receivable_installments, allow_destroy: true

  has_paper_trail

  validates :bill_receivable_installments, presence: true
  validates :total_value, numericality: { greater_than: 0 }

  validates :budget, presence: true, if: :budget?

  validates :name_other, presence: true, if: :other?
  validates :phone_other, presence: true, if: :other?

  validates_presence_of :cpf_other, :unless => :cpf?
  validates_presence_of :cnpj_other, :unless => :cnpj?

  before_create :set_due_date_and_status
  before_update :due_date_verify

  after_update :set_value

  def due_date_verify
    data = []
    check = true
    self.bill_receivable_installments.map do |e|
      if e.status == 'pending'
        data << e.date
        check = false
      end
    end
    if data.present?
      self.due_date = data.sort.first
      if self.due_date < Date.today
        self.status = 1
      else
        self.status = 0
      end
    else
      if check
        self.status = 2
      end
    end
  end

  def set_due_date_and_status
    data = []
    self.bill_receivable_installments.map { |e| data << e.date }
    self.due_date = data.sort.first
    if self.due_date < Date.today
      self.status = 1
    else
      self.status = 0
    end
  end

  private

    def set_value
      total_bill = self.total_value.round(2)
      value_item = self.bill_receivable_installments.sum(:value).round(2)
      interest_item = self.bill_receivable_installments.sum(:interest).round(2)
      ActiveRecord::Base.transaction do
        unless total_bill == value_item
          self.update total_value: value_item
        end
        unless self.interest == interest_item
          self.update interest: interest_item
        end
      end
    end

    def other?
      self.type_receivable == 'other'
    end

    def budget?
      self.type_receivable == 'budget'
    end

    def cpf?
      self.cnpj_other.present? or !other?
    end

    def cnpj?
      self.cpf_other.present? or !other?
    end
end
