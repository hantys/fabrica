module BudgetsHelper
  def label_status_budget(budget)
    # waiting: 0, rejected: 1, authorized: 2, billed: 3, delivered: 4
    # budget.status_i18n
    if budget.class == String
      status = budget
    else
      status = budget.status
    end
    aux = ''
    text = t "enums.budget.status.#{status}"

    case status
    when 'waiting'
      aux = "<span class='badge badge-warning' style='font-size:14px;'>#{text}</span>"
    when 'confirm'
      aux = "<span class='badge badge-info' style='font-size:14px;'>#{text}</span>"
    when 'rejected'
      aux = "<span class='badge badge-danger' style='font-size:14px;'>#{text}</span>"
    when 'authorized'
      aux = "<span class='badge badge-success' style='font-size:14px;'>#{text}</span>"
    when 'billed'
      aux = "<span class='badge badge-primary' style='font-size:14px;'>#{text}</span>"
    when 'delivered'
      aux = "<span class='badge badge-dark' style='font-size:14px;'>#{text}</span>"
    end
    return aux.html_safe
  end
end
