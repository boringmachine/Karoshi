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
  size = $(window).width()

  widthIsOver850 = () ->
    $("#new_post_section").css({"position":"fixed","float":"left","left":"50px","top":"100px"})
    $("#group_posts").css({"position":"relative","left":"20%"})
    $("#post_list").css({"position":"relative","left":"20%"})
    $("#post_list article").addClass("arrow_box")
    $("#post_list article").removeClass("post_article")
    
  widthIsUnder850 = () ->
    $("#new_post_section").css({"position":"relative","float":"none","left":"0px","top":"0px"})
    $("#group_posts").css({"position":"relative","left":"0%"})
    $("#post_list").css({"position":"relative","left":"0%"})
    $("article").removeClass({"arrow_box"})
    $("article").addClass({"post_article"})

  responsiveWindow = ()->
    if $(window).width() > 850
      widthIsOver850()

    else
      widthIsUnder850()
  
  if size > 850
    widthIsOver850()

  $(window).resize ->
    responsiveWindow()

  $(window).bottom()
  $(window).bind "bottom", ->
    $("#infbtn input").click ->
      responsiveWindow()
    $("#infbtn input").click()
    responsiveWindow()

