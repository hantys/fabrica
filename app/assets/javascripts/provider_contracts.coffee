# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('.value_budget').on 'input', ->
    setTotalValue()

  $(document).on 'nested:fieldRemoved:item_provider_contracts', (event) ->
    field = event.field
    # it's a jQuery object already! Now you can find date input
    value_budget = field.find('.value_budget')
    value_budget.val(0)
    setTotalValue()


  $(document).on 'nested:fieldAdded', (event) ->
    $('.simple-select2').select2
      theme: 'bootstrap4'
      allowClear: true
    # this field was just inserted into your form
    field = event.field

    value_budget = field.find('.value_budget')

    value_budget.on 'input', ->
      setTotalValue()


@setTotalValue = () ->
  sum = 0
  $('.value_budget').each ->
    sum += parseFloat(@value)
  $('#provider_contract_total_value').val sum.toFixed(2)