class UpdateBillPayableJob < ApplicationJob
  queue_as :default
  retry_on ActiveRecord::Deadlocked, wait: 5.seconds, attempts: 3
  retry_on Net::OpenTimeout, wait: :exponentially_longer, attempts: 10
  discard_on ActiveJob::DeserializationError

  def perform(bill_payable_id)
    bill_payable = BillPayable.find bill_payable_id
    status = bill_payable.status

    bill_payable.due_date_verify
    if status != bill_payable.status
      bill_payable.save
    end
    GC.start
  end
end
