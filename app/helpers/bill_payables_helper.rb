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
end
