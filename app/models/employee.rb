class Employee < ApplicationRecord
  belongs_to :state
  belongs_to :city
  belongs_to :user
end
