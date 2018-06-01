class Client < ApplicationRecord
  belongs_to :state
  belongs_to :city
  belongs_to :employee
end
