class UpdateBillReceivableJob < ApplicationJob
  queue_as :default
  retry_on ActiveRecord::Deadlocked, wait: 5.seconds, attempts: 3
  retry_on Net::OpenTimeout, wait: :exponentially_longer, attempts: 10
  discard_on ActiveJob::DeserializationError

  def perform(bill_receivable_id)
    bill_receivable = BillReceivable.find bill_receivable_id
    status = bill_receivable.status

    bill_receivable.due_date_verify

    if status != bill_receivable.status
      bill_receivable.save
    end
    GC.start
  end
end
