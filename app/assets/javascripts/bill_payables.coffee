# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#select_all").click ->
    $(".styled").each ->
      $(this).attr("checked", !$(this).attr("checked"))

  $('#bill_payable_provider_contract_id').change ->
    $.getJSON "/provider_contracts/#{$(this).val()}", {modal: 'true'}, (data) ->
      $('#bill_payable_total_value').val (parseFloat(data['total_value']) - parseFloat(data['partil_value'])).toFixed(2)

  $(document).on 'nested:fieldAdded:bill_payable_installments', (event) ->
    init_all_js_basic()
    # this field was just inserted into your form
    field = event.field
    date_input = field.find('.datepicker-here')
    date_input.datepicker()
    # file_name = field.find('.file-name')
    # icon_file = field.find('.icon-file')

    # file_update.change ->
    #   file_name.text($(this).val().replace(/C:\\fakepath\\/i, ''))
    #   icon_file.text('cloud_done')
    #   icon_file.removeClass('badge-danger').addClass('badge-success')

@change_icon_file=(object)->
  field = object.closest('.change_icon_file')
  file_name = field.find('.file-name')
  icon_file = field.find('.icon-file')

  file_name.text(object.val().replace(/C:\\fakepath\\/i, ''))
  icon_file.text('cloud_done')
  icon_file.removeClass('badge-danger').addClass('badge-success')

@change_type_payment=(type_name, id)->
  $("##{id}").val(type_name)

@change_bar_code=(type, id)->
  if type.val() == 'true'
    $("##{id}").mask '00000.00000 00000.000000 00000.000000 0 00000000000000', reverse: false
  else
    $("##{id}").mask '00000000000-0 00000000000-0 00000000000-0 00000000000-0', reverse: false