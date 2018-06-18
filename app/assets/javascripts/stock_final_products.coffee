# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@changeKindSFP = (element) ->
  if $(element).val() == 'raw_material'
    $(".raw-material").removeClass('d-none')
    $(".product").addClass('d-none')

  if $(element).val() == 'product'
    $(".product").removeClass('d-none')
    $(".raw-material").addClass('d-none')

jQuery ->

  if $('#stock_final_product_kind').val() == 'raw_material'
    $(".raw-material").removeClass('d-none')
    $(".product").addClass('d-none')

  if $('#stock_final_product_kind').val() == 'product'
    $(".product").removeClass('d-none')
    $(".raw-material").addClass('d-none')
