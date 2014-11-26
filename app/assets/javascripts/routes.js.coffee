# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#route-generate").on "click" , ->
    turn = $("#turn-select").val()
    direction = $("#direction-select").val()
    window.location.href = "/generate_new_route/" + turn + "/" + direction
