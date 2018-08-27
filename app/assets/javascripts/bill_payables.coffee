# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->

  $('#bill_payable_provider_contract_id').change ->
    $.getJSON "/provider_contracts/#{$(this).val()}", {modal: 'true'}, (data) ->
      $('#bill_payable_total_value').val (parseFloat(data['total_value']) - parseFloat(data['partil_value'])).toFixed(2)

  $(document).on 'nested:fieldAdded:bill_payable_installments', (event) ->
    init_all_js_basic()
    # this field was just inserted into your form
    # field = event.field
    # file_update = field.find('.update_file_by_icon')
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