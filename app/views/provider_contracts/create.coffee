<% if @provider_contract.errors.present? %>
  $(".modal-body").find(".new_form_remote").html("<%= escape_javascript(render partial: 'form', locals: {:'@provider_contract' => @provider_contract}) %>")
  init_all_js_basic()
<% else %>
  if $('#bill_payable_provider_contract_id').find('option[value=\'' + <%= @provider_contract.id %> + '\']').length
    $('#bill_payable_provider_contract_id').val('<%= @provider_contract.id %>').trigger 'change'
  else
    # Create a DOM Option and pre-select by default
    newOption = new Option('<%= @provider_contract.name %>', <%= @provider_contract.id %>, true, true)
    # Append it to the select
    $('#bill_payable_provider_contract_id').append(newOption).trigger 'change'
    $(".modal-body").find(".new_form_remote").html("<div class='alert alert-success text-center'>Fornecedor cadastrado com sucesso!</div>")
    $('#bill_payable_total_value').val '<%= @provider_contract.total_value - @provider_contract.partil_value %>'
  window.setTimeout (->
    $('#form_object').modal('hide')
  ), 1000
<% end %>