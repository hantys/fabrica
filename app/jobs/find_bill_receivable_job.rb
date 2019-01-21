class FindBillReceivableJob < ApplicationJob
  queue_as :default

  def perform(*args)
    BillReceivable.where(status: [0, 1]).pluck(:id).each do |bill_receivable_id|
      UpdateBillReceivableJob.perform_now bill_receivable_id
    end
  end
end
