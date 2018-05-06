# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('input:radio[name="composition[kind]"]').change ->
    $.ajax
      url: "/render/compositionals_or_compositions/#{$(this).val()}"
