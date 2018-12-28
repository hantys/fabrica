module BillPayablesHelper
  def label_status_bp(bill_payable)
    # pending: 0, late: 1, paid: 2
    # bill_payable.status_i18n
    status = bill_payable.status

    bill_payable.due_date_verify

    if status != bill_payable.status
      bill_payable.save
      status = bill_payable.status
    end
    aux = ''
    text = t "enums.bill_payable.status.#{status}"

    case status
    when 'paid'
      aux = "<span class='badge badge-success' style='font-size:14px;'>#{text}</span>"
    when 'pending'
      aux = "<span class='badge badge-warning' style='font-size:14px;'>#{text}</span>"
    when 'late'
      aux = "<span class='badge badge-danger' style='font-size:14px;'>#{text}</span>"
    end
    return aux.html_safe
  end

  def label_status_bpi(bill_payable_installment)
    # pending: 0, late: 1, paid: 2
    # bill_payable.status_i18n
    bill_payable = bill_payable_installment.bill_payable
    status_bill = bill_payable.status

    bill_payable.due_date_verify

    if status_bill != bill_payable.status
      bill_payable.save
    end

    status = bill_payable_installment.status
    if bill_payable_installment.date < Date.today and status != "paid"
      status = "late"
    end

    aux = ''
    text = t "enums.bill_payable_installment.status.#{bill_payable_installment.status}"

    case status
    when 'paid'
      aux = "<span class='badge badge-success' style='font-size:14px;'>#{text}</span>"
    when 'pending'
      aux = "<span class='badge badge-warning' style='font-size:14px;'>#{text}</span>"
    when 'late'
      aux = "<span class='badge badge-danger' style='font-size:14px;'>#{text}</span>"
    end
    return aux.html_safe
  end
end
