class Employee < ApplicationRecord
  belongs_to :state
  belongs_to :city
  has_one :user
end
