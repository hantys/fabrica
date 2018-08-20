module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? 'active' : ""
  end

  def link_to_modal(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}
    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    html_options.merge! data: { toggle: "modal", target: "#show_object", link: url }
    html_options["href".freeze] ||= "javascript:;"

    content_tag("a".freeze, name || url, html_options, &block)
  end

  def link_to_modal_form(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}
    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    html_options.merge! data: { toggle: "modal", target: "#form_object", link: url }
    html_options["href".freeze] ||= "javascript:;"

    content_tag("a".freeze, name || url, html_options, &block)
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
