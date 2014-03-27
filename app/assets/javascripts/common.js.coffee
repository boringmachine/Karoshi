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
  $('iframe').each ->
    url = $(this).attr("src")
    $(this).attr("src",url+"?wmode=transparent")
    
$ ->
  widthIsOver850 = () ->

    
  widthIsUnder850 = () ->


  responsiveWindow = ()->
    if $(window).width() > 850
      widthIsOver850()

    else
      widthIsUnder850()
  
  if $(window).width() > 850
    widthIsOver850()

  $(window).resize ->
    responsiveWindow()

  $("#infbtn input").click ->
    responsiveWindow()

  $(window).bottom()
  $(window).bind "bottom", ->
    $("#infbtn input").click()

