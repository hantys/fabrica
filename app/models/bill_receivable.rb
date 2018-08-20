class BillReceivable < ApplicationRecord
  acts_as_paranoid

  belongs_to :budget, -> { with_deleted }
  belongs_to :category, -> { with_deleted }
  belongs_to :revenue, -> { with_deleted }
end
