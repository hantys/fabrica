<% if @provider.errors.present? %>
  $(".new_form_remote").html("<%= escape_javascript(render partial: 'form', locals: {:'@provider' => @provider}) %>")
  init_all_js_basic()
<% else %>
  init_all_js_basic()
  if $('#provider_contract_provider_id').find('option[value=\'' + <%= @provider.id %> + '\']').length
    $('#provider_contract_provider_id').val('<%= @provider.id %>').trigger 'change'
  else
    # Create a DOM Option and pre-select by default
    newOption = new Option('<%= @provider.name %>', <%= @provider.id %>, true, true)
    # Append it to the select
    $('#provider_contract_provider_id').append(newOption).trigger 'change'
    $(".new_form_remote").html("<div class='alert alert-success text-center'>Fornecedor cadastrado com sucesso!</div>")
  window.setTimeout (->
    $('#form_object').modal('hide')
  ), 1000
<% end %>
