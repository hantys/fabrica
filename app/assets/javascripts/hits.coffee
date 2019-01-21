# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@setHitItems = (element) ->
  $.get("/load_hit_items/#{$(element).val()}", ->
    console.log 'success'
  ).done(->
    console.log 'second success'
  ).fail(->
    console.log 'error'
  ).always(->
    console.log 'finished'
  )