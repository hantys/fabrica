$("#budget-item-<%= @budget.id %>").html("<%= escape_javascript(render partial: 'budgets_item', locals: {:'budget' => @budget}) %>")

<% if @new_bill.present? %>
window.location.href = "<%= @new_bill %>";
<% end %>
<% if @update_status.present? %>
$('#update_status').modal('toggle')
# $('#obs-status-budget').val('')
document.getElementById('obs-status').value = ''
<% end %>

$('.alert').stop().fadeTo(500, 1).removeClass 'd-none'
window.setTimeout (->
  $('.alert').fadeTo(1000, 0).slideUp 500, ->
    $(".alert").alert('close')
), 3000
