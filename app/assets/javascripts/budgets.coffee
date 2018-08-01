jQuery ->
  $('#budget_product_reserve').on 'show.bs.modal', (event) ->
    button = $(event.relatedTarget)
    # Button that triggered the modal
    title = button.data('whatever')
    id = button.data('id')

    modal = $(this)
    modal.find('.modal-title').text 'Reservar ' + title

    $.get '/busca/orcamento/reserve_product/' + id, {}, ((data) ->
      modal.find('.modal-body').html(data)
    ), 'html'

  $('#product').on 'show.bs.modal', (event) ->
    button = $(event.relatedTarget)
    # Button that triggered the modal
    id = button.data('id')

    modal = $(this)

    $.get '/products/' + id, {modal: 'true'}, ((data) ->
      modal.find('.modal-body').html(data)
    ), 'html'

  $('#budget_product_reserve').on 'hidden.bs.modal', (event) ->
    modal = $(this)
    modal.find('.modal-body').html ''
    modal.find('.modal-title').text 'Reservar '


  $('.product').change ->
    unit_value = $(this).parent().parent().parent().find('.unit_value')
    qnt = $(this).parent().parent().parent().find('.qnt')
    total_value = $(this).parent().parent().parent().find('.total_value')
    total_value_with_discount = $(this).parent().parent().parent().find('.total_value_with_discount')
    discount_type = $(this).parent().parent().parent().find('.discount_type')
    discount = $(this).parent().parent().parent().parent().find('.discount_item')
    console.log $(this).val()
    $.get("/find_product/#{$(this).val()}", (date) ->
      unit_value.val date
      $('#budget_discount').val('')
      if qnt.val().length > 0
        if qnt.val() == '0.0' or qnt.val() == '0'
          discount.attr("readonly", true)
          discount.val(0)
          total_value_with_discount.val(0)
        else
          total_value.val (parseFloat(unit_value.val()) * parseFloat(qnt.val())).toFixed(2)
          calcDiscountUnit(discount, discount_type, unit_value, qnt, total_value_with_discount)
          discount.attr("readonly", false)
          setTotalBudget()
          setTotalDiscountBudget()
      else
        discount.attr("readonly", true)
        discount.val(0)
        total_value_with_discount.val(0)
    ).done(->
      # console.log 'second success'
    ).fail(->
      # console.log 'error'
    ).always(->
      # console.log 'finished'
    )

  $('.discount_item').on 'input', ->
    unit_value = $(this).parent().parent().parent().find('.unit_value')
    qnt = $(this).parent().parent().parent().find('.qnt')
    total_value = $(this).parent().parent().parent().find('.total_value')
    total_value_with_discount = $(this).parent().parent().parent().find('.total_value_with_discount')
    discount_type = $(this).parent().parent().parent().find('.discount_type')
    discount = $(this)
    calcDiscountUnit(discount, discount_type, unit_value, qnt, total_value_with_discount)
    setTotalDiscountBudget()

  $('.discount_type').click ->
    unit_value = $(this).parent().parent().parent().parent().find('.unit_value')
    qnt = $(this).parent().parent().parent().parent().find('.qnt')
    total_value = $(this).parent().parent().parent().parent().find('.total_value')
    total_value_with_discount = $(this).parent().parent().parent().parent().find('.total_value_with_discount')
    discount_type = $(this)
    discount = $(this).parent().parent().parent().parent().find('.discount_item')
    calcDiscountUnit(discount, discount_type, unit_value, qnt, total_value_with_discount)
    setTotalDiscountBudget()

  $('.qnt').on 'input', ->
    unit_value = $(this).parent().parent().parent().find('.unit_value')
    qnt = $(this)
    total_value = $(this).parent().parent().parent().find('.total_value')
    total_value_with_discount = $(this).parent().parent().parent().find('.total_value_with_discount')
    discount_type = $(this).parent().parent().parent().find('.discount_type')
    discount = $(this).parent().parent().parent().find('.discount_item')

    if unit_value.val().length > 0 and qnt.val().length > 0
      total_value.val((parseFloat(unit_value.val()) * parseFloat(qnt.val())).toFixed(2))
      calcDiscountUnit(discount, discount_type, unit_value, qnt, total_value_with_discount)
      setTotalBudget()
      setTotalDiscountBudget()
      discount.attr("readonly", false)
    if qnt.val().length == 0 or qnt.val() == '0'
      total_value.val 0
      discount.val 0
      total_value_with_discount.val 0
      discount.attr("readonly", true)

  if $('#budget_delivery_option_id').length > 0
    $('#budget_delivery_option_id').change ->
      $.get("/busca/sub-item-entrega/#{$(this).val()}", (data) ->
        $('#budget_sub_delivery_option_id').html ''
        $('#budget_sub_delivery_option_id').append "<option value=\"\">Escolha um tipo</option>"
        for item in data
          $('#budget_sub_delivery_option_id').append "<option value='#{item.id}'>#{item.name}</option>"
      ).done(->
        # console.log 'second success'
      ).fail(->
        # console.log 'error'
      ).always(->
        # console.log 'finished'
      )

  if $('#budget_type_of_payment_id').length > 0
    $('#budget_type_of_payment_id').change ->
      $.get("/busca/sub-item-pagamento/#{$(this).val()}", (data) ->
        $('#budget_sub_type_payment_id').html ''
        $('#budget_sub_type_payment_id').append "<option value=\"\">Escolha um tipo</option>"
        for item in data
          $('#budget_sub_type_payment_id').append "<option value='#{item.id}'>#{item.name}</option>"
      ).done(->
        # console.log 'second success'
      ).fail(->
        # console.log 'error'
      ).always(->
        # console.log 'finished'
      )

  $('#budget_value').on 'change_value', ->
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
      if $(this).val() > 0
        $('#budget_discount').attr("readonly", false)

  $('#budget_discount').on 'input', ->
    calcDiscount($('#budget_discount'), $('#budget_discount_type'), $('#budget_value'), $('#budget_value_with_discount'))

  $('#budget_discount_type').click ->
    unless $('#budget_discount').length == 0 or $('#budget_discount').val() == ''
      calcDiscount($('#budget_discount'), $('#budget_discount_type'), $('#budget_value'), $('#budget_value_with_discount'))

$(document).on 'nested:fieldRemoved:budget_products', (event) ->
  field = event.field
  # it's a jQuery object already! Now you can find date input
  totalValueWithDiscountField = field.find('.total_value_with_discount')
  budgetItemField = field.find('.product')
  unitValueField = field.find('.unit_value')
  qntField = field.find('.qnt')
  discountField = field.find('.discount_item')
  discountTypeField = field.find('.discount_type')
  totalValueField = field.find('.total_value')

  discountField.val(0)
  totalValueField.val(0)
  totalValueWithDiscountField.val(0)

  setTotalBudget()
  setTotalDiscountBudget()

$(document).on 'nested:fieldAdded', (event) ->
  $('.simple-select2').select2
    theme: 'bootstrap4'
    allowClear: true
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
    calcDiscountUnit(discountField, discountTypeField, unitValueField, qntField, totalValueWithDiscountField)
    setTotalDiscountBudget()

  discountTypeField.click ->
    calcDiscountUnit(discountField, discountTypeField, unitValueField, qntField, totalValueWithDiscountField)
    setTotalDiscountBudget()

  qntField.on 'input', ->
    if unitValueField.val().length > 0 and qntField.val().length > 0
      totalValueField.val((parseFloat(unitValueField.val()) * parseFloat(qntField.val())).toFixed(2))
      calcDiscountUnit(discountField, discountTypeField, unitValueField, qntField, totalValueWithDiscountField)
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
      $('#budget_discount').val('')
      if qntField.val().length > 0
        if qntField.val() == '0.0' or qntField.val() == '0'
          discountField.attr("readonly", true)
          discountField.val(0)
          totalValueWithDiscountField.val(0)
        else
          totalValueField.val (parseFloat(unitValueField.val()) * parseFloat(qntField.val())).toFixed(2)
          calcDiscountUnit(discountField, discountTypeField, unitValueField, qntField, totalValueWithDiscountField)
          discountField.attr("readonly", false)
          setTotalBudget()
          setTotalDiscountBudget()
      else
        discountField.attr("readonly", true)
        discountField.val(0)
        totalValueWithDiscountField.val(0)
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
  $('#budget_value').trigger 'change_value'

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
  total = parseFloat($('#budget_value').val()) - sum.toFixed(2)
  $('#budget_value_with_discount').val total.toFixed(2)
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

@calcDiscountUnit = (discount, discount_type, unit_value, qnt, field_value_discount) ->
  discount_val = parseFloat(discount.val())
  unit_value_val = parseFloat(unit_value.val())
  qnt_val = parseFloat(qnt.val())
  if discount_type.is(':checked')
    discount_calc = ((unit_value_val * discount_val) / 100).toFixed(2)
  else
    discount_calc = discount_val.toFixed(2)

  if discount_val == 0 or discount.val().length == 0
    field_value_discount.val 0
  else
    field_value_discount.val discount_calc * qnt_val