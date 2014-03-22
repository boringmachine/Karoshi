# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#topic_info").hide()
  opened = off
  $("#opentopics").click ->
    if opened is on
      $("#topic_info").hide()
      $(this).text("Open Topic Info")
    else
      $("#topic_info").show()
      $(this).text("Close Topic Info")
    opened = !opened
