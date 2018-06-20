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

  if $('#stock_final_product_residue').length != 0
    $('#stock_final_product_weight').keyup ->
      $('#stock_final_product_residue').val(0)
      $('#stock_final_product_residue').val((parseFloat($('#stock_final_product_hit_weigth').val()) - parseFloat($('#stock_final_product_weight').val())).toFixed(2))

  if $('#stock_final_product_hit_id').length > 0
    $('#stock_final_product_hit_id').change ->
      $.get("/busca/batida/#{$(this).val()}", (data) ->
        $('#stock_final_product_hit_weigth').val null
        $('#stock_final_product_hit_weigth').val data
        $('#stock_final_product_residue').val(null)
        if $('#stock_final_product_weight').length > 0
          $('#stock_final_product_residue').val((parseFloat(data) - parseFloat($('#stock_final_product_weight').val())).toFixed(2))
      ).done(->
        # console.log 'second success'
      ).fail(->
        # console.log 'error'
      ).always(->
        # console.log 'finished'
      )

  if $('#derivative_product').length > 0
    $('#derivative_product').change ->
      $.get("/busca/produto-primitivo/#{$(this).val()}", (data) ->
        $('#stock_final_product_derivative_qnt').val null
        $('#stock_final_product_derivative_qnt').val data
      ).done(->
        # console.log 'second success'
      ).fail(->
        # console.log 'error'
      ).always(->
        # console.log 'finished'
      )

