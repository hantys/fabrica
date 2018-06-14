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

  def representative_ids
    ids = []
    User.all.each do |single|
      if single.has_role?(:representative)
        ids << single.employee_id
      end
    end
    return ids
  end
end
