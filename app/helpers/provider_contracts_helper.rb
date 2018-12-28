module ProviderContractsHelper
  def label_status_pc(provider_contract)
    # waiting: 0, rejected: 1, authorized: 2, billed: 3, delivered: 4
    # provider_contract.status_i18n
    if provider_contract.class == String
      status = provider_contract
    else
      status = provider_contract.status
    end
    aux = ''
    text = t "enums.provider_contract.status.#{status}"

    case status
    when 'active'
      aux = "<span class='badge badge-success' style='font-size:14px;'>#{text}</span>"
    when 'finish'
      aux = "<span class='badge badge-dark' style='font-size:14px;'>#{text}</span>"
    end
    return aux.html_safe
  end
end
