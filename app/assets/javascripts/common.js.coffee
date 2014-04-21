
widthIsOver850 = () ->
  $("article, .body *, article header").width("500")
  $("#tags, .group_body").show("fadein") 
widthIsUnder850 = () ->
  $("article, .body *, article header").width("310")
  $("#tags, .group_body").hide("fadeout")
  
responsiveWindow = ()->
  $('iframe').each ->
    url = $(this).attr("src")
    $(this).attr("src",url+"?wmode=transparent")

  if $(window).width() > 850
    widthIsOver850()
  else
    widthIsUnder850()

hidePostFormElms = (fadebool) ->
  if(typeof fadebool == 'undefined') then fadebool = true
  if fadebool is on then fade = "fade"
  $("#new_post select").hide(fade)
  $("#new_post input[type='file']").hide(fade)
  $("#new_post label").hide(fade)
  $("#new_post textarea").height(75)

ajaxEnd = () ->
  responsiveWindow()

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

  $(document).ajaxComplete(ajaxEnd)

# post form init    
$ ->
  hidePostFormElms(false)
  
  $("#new_post textarea").click ->
    $("#new_post select").show("fade")
    $("#new_post input[type='file']").show("fade")
    $("#new_post label").show("fade")
    $("#new_post textarea").height("150")

# infbtn init
$ ->
  $(window).bottom({proximity: 0});
  $(window).on 'bottom', ->
    $("#infbtn input[type='submit']").click()
    

