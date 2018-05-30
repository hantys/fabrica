class Budget < ApplicationRecord
  belongs_to :client
  belongs_to :employee
end
