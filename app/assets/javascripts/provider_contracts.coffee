# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  on_input_value()

  $(document).on 'nested:fieldRemoved:item_provider_contracts', (event) ->
    field = event.field
    # it's a jQuery object already! Now you can find date input
    item_provider_contract_value_budget = field.find('.item_provider_contract_value_budget')
    item_provider_contract_value_budget.val(0)
    setTotalValue()


  $(document).on 'nested:fieldAdded:item_provider_contracts', (event) ->
    $('.simple-select2').select2
      theme: 'bootstrap4'
      allowClear: true
    # this field was just inserted into your form
    field = event.field
    on_input_value()

  $(document).on 'nested:fieldAdded:budget_provider_contracts', (event) ->
    $('.simple-select2').select2
      theme: 'bootstrap4'
      allowClear: true

@setTotalValue = () ->
  sum = 0
  $('.item_provider_contract_value_budget').each ->
    sum += parseFloat(@value)
  $('#provider_contract_total_value').val sum.toFixed(2)

@on_input_value=(type, id)->
  $('.item_provider_contract_value_budget').on 'input', ->
    setTotalValue()