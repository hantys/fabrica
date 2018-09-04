# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#select_all").click ->
    count = 0
    $(".styled").each ->
      $(this).prop("checked", !$(this).prop("checked"))
      if $(this).prop("checked")
        count =+ 1
        $("#check_#{$(this).prop("id")}").html('check_box')
      else
        $("#check_#{$(this).prop("id")}").html('check_box_outline_blank')
    if count > 0
      $(".pay_all").prop("disabled", false)
    else
      $(".pay_all").prop("disabled", true)

  on_input_value()

  $(document).on 'nested:fieldRemoved:bill_receivable_installments', (event) ->
    field = event.field
    # it's a jQuery object already! Now you can find date input
    value_budget = field.find('.value_budget')
    value_budget.val(0)
    setTotalValue()

  $(document).on 'nested:fieldAdded:bill_receivable_installments', (event) ->
    init_all_js_basic()
    # this field was just inserted into your form
    field = event.field
    date_input = field.find('.datepicker-here')
    date_input.datepicker()
    on_input_value()


@change_type_receivable=(type_name, id)->
  $("##{id}").val(type_name)

@change_icon_file=(object)->
  field = object.closest('.change_icon_file')
  file_name = field.find('.file-name')
  icon_file = field.find('.icon-file')

  file_name.text(object.val().replace(/C:\\fakepath\\/i, ''))
  icon_file.text('cloud_done')
  icon_file.removeClass('badge-danger').addClass('badge-success')

@setTotalValue = () ->
  sum = 0
  $('.value_budget').each ->
    sum += parseFloat(@value)
  $('#bill_receivable_total_value').val sum.toFixed(2)

@on_input_value=(type, id)->
  $('.value_budget').on 'input', ->
    setTotalValue()

@change_check_pay=(object)->
  $("##{object}").prop('checked', !$("##{object}").prop('checked'))
  if $("##{object}").prop("checked")
    count =+ 1
    $("#check_#{$("##{object}").prop("id")}").html('check_box')
  else
    $("#check_#{$("##{object}").prop("id")}").html('check_box_outline_blank')
  $(".styled").each ->
    if $(this).prop("checked")
      count =+ 1
  if count > 0
    $(".pay_all").prop("disabled", false)
  else
    $(".pay_all").prop("disabled", true)