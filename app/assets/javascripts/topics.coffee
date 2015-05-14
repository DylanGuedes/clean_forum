# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.doing_quote').click ->
    console.log($(this)[0].id)
    $('#target_'+$(this)[0].id).toggle('fast')

  $('.quote_mainpost').click ->
    $('.target_mainpost').toggle('fast')