
widthIsOver850 = () ->
  #$("article, .body *, article header").width("500")
  #$("#tags, .group_body").show("fadein")
  top = $("#new_post_section form").position().top + $("#new_post_section").height() + 50
  left_height = top
  right_height = top
  leftflag = on
  $(".post_article").each ->
    article_height = $(this).height() + 90
    article_half_width = $(this).width()/2
    leftflag = if left_height <= right_height then on else off
    
    if leftflag is on
      $(this).css({position:"absolute",top:left_height,left:"50%","margin-left":-200-article_half_width})
      left_height += article_height
    else
      $(this).css({position:"absolute",top:right_height,left:"50%","margin-left":200-article_half_width})
      right_height += article_height
  
  
widthIsUnder850 = () ->
  #$("article, .body *, article header").width("310")
  #$("#tags, .group_body").hide("fadeout")
  $(".post_article").css({position:"relative",top:"",left:"","margin-left":""})
  
  
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
    

