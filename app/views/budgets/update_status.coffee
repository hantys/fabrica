$("#budget-item-<%= @budget.id %>").html("<%= escape_javascript(render partial: 'budgets_item', locals: {:'budget' => @budget}) %>")

$('.alert').stop().fadeTo(500, 1).removeClass 'd-none'
window.setTimeout (->
  $('.alert').fadeTo(1000, 0).slideUp 500, ->
    $(".alert").alert('close')
), 3000
