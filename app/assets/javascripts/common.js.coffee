sleep = (time, callback) ->
  setTimeout(callback, time)

widthIsOver850 = () ->
  $("article, article div, article header, article .image img, article iframe").width("500")
  $("#tags").show("fadein") 
widthIsUnder850 = () ->
  $("article, article div, article header, article .image img, article iframe").width("310")
  $("#tags").hide("fadeout")
  
responsiveWindow = ()->
  $('iframe').each ->
  url = $(this).attr("src")
  $(this).attr("src",url+"?wmode=transparent")

  if $(window).width() > 850
    widthIsOver850()
  else
    widthIsUnder850()

$ ->
  $('a.fancybox').fancybox()

$ ->
	$("#submit_path").change ->
		val = $('#submit_path option:selected').val()
		if val is "1" then sel = "/posts"
		else if val is "2" then sel = "/groups"
		else sel = "/topics"

		$("#search_post form").attr("action",sel)
		
$ ->
  menubool = true
  $("#sidebar").hide()
  $("#menu").click ->
    if menubool is on
      $("#sidebar").show()
    else
      $("#sidebar").hide()
    menubool = !menubool
    
$ ->    
  $("#tags").hide()
  responsiveWindow()

  $(window).resize ->
    responsiveWindow()
    
  $("#infbtn input[type='submit']").click ->
    sleep(500, responsiveWindow)
    
$ ->
  $("#new_post select").hide()
  $("#new_post input[type='file']").hide()
  $("#new_post label").hide()
  
  $("#new_post textarea").click ->
    $("#new_post select").show("fade")
    $("#new_post input[type='file']").show("fade")
    $("#new_post label").show("fade")
    $("#new_post textarea").height("150")

#$ ->
#  $(window).bottom({proximity: 0.2});
#  $(window).on 'bottom', ->
#    $("#infbtn input[type='submit']").click()
    

