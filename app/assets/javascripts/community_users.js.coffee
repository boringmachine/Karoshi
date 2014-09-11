# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#community_user_button form[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    if $(this).attr("class") is "new_community_user"
      alert "Join Success"
    else
      alert "Leave Success"
    
    $(this).hide()
