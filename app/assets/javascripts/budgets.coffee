$(document).on 'nested:fieldAdded', (event) ->
  # this field was just inserted into your form
  field = event.field
  # it's a jQuery object already! Now you can find date input
  budgetItemField = field.find('.budget_item')
  unitValueField = field.find('.unit_value')
  qntField = field.find('.qnt')
  totalValueField = field.find('.total_value')

  qntField.on 'input', ->
    if unitValueField.val().length > 0 and qntField.val().length > 0
      totalValueField.val((parseFloat(unitValueField.val()) * parseFloat(qntField.val())).toFixed(2))
      settotalBudget()
    if qntField.val().length == 0
        totalValueField.val 0

  budgetItemField.change ->
    $.get("/find_budget_item/#{$(this).val()}", (date) ->
      unitValueField.val date
      if qntField.val().length > 0
        totalValueField.val (parseFloat(unitValueField.val()) * parseFloat(qntField.val())).toFixed(2)
        settotalBudget()
    ).done(->
      # console.log 'second success'
    ).fail(->
      # console.log 'error'
    ).always(->
      # console.log 'finished'
    )

@settotalBudget = () ->
  sum = 0
  $('.total_value').each ->
    sum += parseFloat(@value)
  $('#budget_value').val sum.toFixed(2)
