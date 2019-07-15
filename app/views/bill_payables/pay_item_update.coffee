<% if @bill_payable.errors.present? %>
  $(".modal-body").find(".new_form_remote").html("<%= escape_javascript(render 'pay_item', locals: { bill_payable: @bill_payable, pay: @pay, modal: @modal }) %>")
  init_all_js_basic()
<% else %>
  init_all_js_basic()
  # Create a DOM Option and pre-select by default
  $("#bill_payable-item-<%= @bill_payable.id %>").html("<%= escape_javascript(render 'bill_payable_item', bill_payable: @bill_payable, bill_payable_installment: @pay) %>")
  $(".modal-body").find(".new_form_remote").html("<div class='alert alert-success text-center'>Conta Paga com sucesso!</div>")
  window.setTimeout (->
    $('#form_object').modal('hide')
  ), 1000
<% end %>
