# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->

@change_type_receivable=(type_name, id)->
  $("##{id}").val(type_name)

@change_icon_file=(object)->
  field = object.closest('.change_icon_file')
  file_name = field.find('.file-name')
  icon_file = field.find('.icon-file')

  file_name.text(object.val().replace(/C:\\fakepath\\/i, ''))
  icon_file.text('cloud_done')
  icon_file.removeClass('badge-danger').addClass('badge-success')