<% if @bill_receivable.errors.present? %>
  $(".modal-body").find(".new_form_remote").html("<%= escape_javascript(render 'receive_item', locals: { bill_receivable: @bill_receivable, receive: @receive, modal: @modal }) %>")
  init_all_js_basic()
<% else %>
  init_all_js_basic()
  # Create a DOM Option and pre-select by default
  $("#bill_receivable-item-<%= @bill_receivable.id %>").html("<%= escape_javascript(render 'bill_receivable_item', bill_receivable: @bill_receivable) %>")
  $(".modal-body").find(".new_form_remote").html("<div class='alert alert-success text-center'>Conta Paga com sucesso!</div>")
  window.setTimeout (->
    $('#form_object').modal('hide')
  ), 1000
<% end %>