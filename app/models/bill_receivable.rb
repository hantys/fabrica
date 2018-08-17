class BillReceivable < ApplicationRecord
  belongs_to :budget
  belongs_to :category
  belongs_to :revenue
end
