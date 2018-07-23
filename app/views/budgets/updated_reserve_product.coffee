$("#budget_product_reserve").find('.modal-body').html("<%= escape_javascript(render partial: 'reserve_product', locals: {:'@budget_product' => @budget_product}) %>")
$('#reserve_qnt-<%= @budget_product.id %>').html('<%= @budget_product.reserve_qnt %>')

$('.alert').stop().fadeTo(500, 1).removeClass 'd-none'
window.setTimeout (->
  $('.alert').fadeTo(1000, 0).slideUp 500, ->
    $(".alert").alert('close')
), 3000
