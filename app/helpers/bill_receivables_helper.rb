module BillReceivablesHelper
  def label_status_br(bill_receivable)
    # pending: 0, late: 1, paid: 2
    # bill_receivable.status_i18n
    status = bill_receivable.status

    # bill_receivable.due_date_verify

    # if status != bill_receivable.status
    #   bill_receivable.save
    #   status = bill_receivable.status
    # end
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
end
