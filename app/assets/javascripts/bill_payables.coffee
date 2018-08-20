# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#bill_payable_file').change ->
    $('#file-name').text($(this).val().replace(/C:\\fakepath\\/i, ''))
    $('#icon-file').text('cloud_done')
    $('#icon-file').removeClass('badge-danger').addClass('badge-success')
