# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  unless $('input:radio[name="composition[kind]"]:checked').val() == undefined
    $(".associations").removeClass('d-none')

  if $('input:radio[name="composition[kind]"]:checked').val() == 'raw_material'
    $(".composition_select").remove()

  if $('input:radio[name="composition[kind]"]:checked').val() == 'composition'
    $(".raw_material_select").remove()

  $('input:radio[name="composition[kind]"]').change ->
    $("#compositionals").html('')

    $(".associations").removeClass('d-none')

$(document).on 'nested:fieldAdded', (event) ->
  # this field was just inserted into your form
  if $('input:radio[name="composition[kind]"]:checked').val() == 'raw_material'
    $(".composition_select").remove()
  else if $('input:radio[name="composition[kind]"]:checked').val() == 'composition'
    $(".raw_material_select").remove()
  $('.simple-select2').select2
    theme: 'bootstrap4'
    allowClear: true
