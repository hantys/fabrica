jQuery ->
  $('#budget_value').on 'input', ->
    alert $(this).val()

  $('#budget_discount').on 'input', ->
    calcDiscount($('#budget_discount'), $('#budget_discount_type'), $('#budget_value'), $('#budget_value_with_discount'))

  $('#budget_discount_type').click ->
    unless $('#budget_discount').length == 0 or $('#budget_discount').val() == ''
      calcDiscount($('#budget_discount'), $('#budget_discount_type'), $('#budget_value'), $('#budget_value_with_discount'))

$(document).on 'nested:fieldAdded', (event) ->
  # this field was just inserted into your form
  field = event.field
  # it's a jQuery object already! Now you can find date input
  totalValueWithDiscountField = field.find('.total_value_with_discount')
  budgetItemField = field.find('.product')
  unitValueField = field.find('.unit_value')
  qntField = field.find('.qnt')
  discountField = field.find('.discount_item')
  discountTypeField = field.find('.discount_type')
  totalValueField = field.find('.total_value')

  discountField.on 'input', ->
    calcDiscount(discountField, discountTypeField, totalValueField, totalValueWithDiscountField)
    setTotalDiscountBudget()

  discountTypeField.click ->
    calcDiscount(discountField, discountTypeField, totalValueField, totalValueWithDiscountField)
    setTotalDiscountBudget()

  qntField.on 'input', ->
    if unitValueField.val().length > 0 and qntField.val().length > 0
      totalValueField.val((parseFloat(unitValueField.val()) * parseFloat(qntField.val())).toFixed(2))
      calcDiscount(discountField, discountTypeField, totalValueField, totalValueWithDiscountField)
      setTotalBudget()
      setTotalDiscountBudget()
      discountField.attr("readonly", false)
    if qntField.val().length == 0 or qntField.val() == '0'
      totalValueField.val 0
      discountField.val 0
      totalValueWithDiscountField.val 0
      discountField.attr("readonly", true)

  budgetItemField.change ->
    $.get("/find_product/#{$(this).val()}", (date) ->
      unitValueField.val date
      if qntField.val().length > 0
        totalValueField.val (parseFloat(unitValueField.val()) * parseFloat(qntField.val())).toFixed(2)
        calcDiscount(discountField, discountTypeField, totalValueField, totalValueWithDiscountField)
        discountField.attr("readonly", false)
        setTotalBudget()
        setTotalDiscountBudget()
    ).done(->
      # console.log 'second success'
    ).fail(->
      # console.log 'error'
    ).always(->
      # console.log 'finished'
    )

@setTotalBudget = () ->
  sum = 0
  $('.total_value').each ->
    sum += parseFloat(@value)
  $('#budget_value').val sum.toFixed(2)

@setTotalDiscountBudget = () ->
  sum = 0
  check = 0
  $('.discount_item').each ->
    if check == 0
      if @value.length != 0
        check = 1
        if @value == '0.0'
          check = 0
        if @value == '0'
          check = 0
  if check == 1
    $('#budget_discount').attr("readonly", true)
    $('#budget_discount').val('')
  else
    $('#budget_discount').attr("readonly", false)

  $('.total_value_with_discount').each ->
    unless @value.length == 0
      sum += parseFloat(@value)
  $('#budget_value_with_discount').val sum.toFixed(2)
  # $('#budget_discount').val sum.toFixed(2)

@calcDiscount = (discount, discount_type, total_value, field_value_discount) ->
  discount_val = parseFloat(discount.val())
  total_value_val = parseFloat(total_value.val())
  if discount_type.is(':checked')
    discount_calc = (total_value_val - ((total_value_val * discount_val) / 100)).toFixed(2)
  else
    discount_calc = (total_value_val - discount_val).toFixed(2)

  if discount_val == 0
    field_value_discount.val null
  else
    field_value_discount.val discount_calc
