module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? 'active' : ""
  end

  def roles_humanize(roles)
    aux = ''
    for role in roles
      aux = aux+'- '+((t :"enums.roles.#{role}")+'<br>')
    end
    return aux.html_safe
  end
end
