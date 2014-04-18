widthIsOver850 = () ->
  $("article, .body *").width("500")
  # $(".linkimg").width("250")
  # $(".linkimg").height("250")
  $("#tags").show("fadein") 
widthIsUnder850 = () ->
  $("article, .body *").width("310")
  # $(".linkimg").width("150")
  # $(".linkimg").height("150")
  $("#tags").hide("fadeout")
  
responsiveWindow = ()->
  $('iframe').each ->
  url = $(this).attr("src")
  $(this).attr("src",url+"?wmode=transparent")

  if $(window).width() > 850
    widthIsOver850()
  else
    widthIsUnder850()

# fancybox init
$ ->
  $('a.fancybox').fancybox()

# searchbar init
$ ->
	$("#submit_path").change ->
		val = $('#submit_path option:selected').val()
		if val is "1" then sel = "/posts"
		else if val is "2" then sel = "/groups"
		else sel = "/topics"

		$("#search_post form").attr("action",sel)

#	sidebar init	
$ ->
  menubool = true
  $("#sidebar").hide()
  $("#menu").click ->
    if menubool is on
      $("#sidebar").show()
    else
      $("#sidebar").hide()
    menubool = !menubool

# responsiveWindow init    
$ ->    
  $("#tags").hide()
  responsiveWindow()

  $(window).resize ->
    responsiveWindow()

  $(document).ajaxComplete(responsiveWindow)

# post form init    
$ ->
  $("#new_post select").hide()
  $("#new_post input[type='file']").hide()
  $("#new_post label").hide()
  
  $("#new_post textarea").click ->
    $("#new_post select").show("fade")
    $("#new_post input[type='file']").show("fade")
    $("#new_post label").show("fade")
    $("#new_post textarea").height("150")

$ ->
  $(window).bottom({proximity: 0});
  $(window).on 'bottom', ->
    $("#infbtn input[type='submit']").click()
    

