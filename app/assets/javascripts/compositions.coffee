# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("##{$('input:radio[name="composition[kind]"]:checked').val()}_fields").removeClass('d-none')
  $('input:radio[name="composition[kind]"]').change ->
    $("#raw_material_fields").addClass('d-none')
    $("#composition_fields").addClass('d-none')
    $("#sub_compositions").html('')
    $("#compositionals").html('')
    $("##{$(this).val()}_fields").removeClass('d-none')
