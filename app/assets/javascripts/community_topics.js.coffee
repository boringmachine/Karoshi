# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#join_topic form[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    alert "Join Success"
    $("#join_topic form select option:selected").remove()
  
  