# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@changeKindSFP = (element) ->
  if $(element).val() == 'raw_material'
    $(".raw-material").removeClass('d-none')
    $(".composition").addClass('d-none')

  if $(element).val() == 'composition'
    $(".composition").removeClass('d-none')
    $(".raw-material").addClass('d-none')