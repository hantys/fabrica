class FindBillPayableJob < ApplicationJob
  queue_as :default

  def perform(*args)
    BillPayable.where(status: [0, 1]).pluck(:id).each do |bill_payable_id|
      UpdateBillPayableJob.perform_now bill_payable_id
    end
  end
end
