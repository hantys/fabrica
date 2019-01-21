module BillReceivablesHelper
  def label_status_br(bill_receivable)
    # pending: 0, late: 1, paid: 2
    # bill_receivable.status_i18n
    status = bill_receivable.status

    bill_receivable.due_date_verify

    if status != bill_receivable.status
      bill_receivable.save
      status = bill_receivable.status
    end
    aux = ''
    text = t "enums.bill_receivable.status.#{status}"

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

  def label_status_bri(bill_receivable_installment)
    # pending: 0, late: 1, paid: 2
    # bill_receivable.status_i18n
    bill_receivable = bill_receivable_installment.bill_receivable
    status_bill = bill_receivable.status

    bill_receivable.due_date_verify

    if status_bill != bill_receivable.status
      bill_receivable.save
    end

    status = bill_receivable_installment.status
    if bill_receivable_installment.date < Date.today and status != "paid"
      status = "late"
    end

    aux = ''
    text = t "enums.bill_receivable_installment.status.#{bill_receivable_installment.status}"

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
