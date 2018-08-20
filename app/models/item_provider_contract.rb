class ItemProviderContract < ApplicationRecord
  acts_as_paranoid

  belongs_to :budget, -> { with_deleted }
  belongs_to :provider_contract, -> { with_deleted }
end
