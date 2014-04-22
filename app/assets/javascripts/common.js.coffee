minIndex = (arr) ->
  i = 0
  tmp = 0
  while(i<arr.length)
    if arr[i] < arr[tmp] then tmp = i
    i++
  return tmp

widthIsOver1250 = () ->
  col_heights = [30, 30, 30]
  add_state = 0
  $(".tlelm").each ->
    article_height = $(this).height() + 90
    article_half_width = $(this).width()/2
    add_state = minIndex(col_heights)
    ma_left = 0

    if add_state is 0
      ma_left = -400
    else if add_state is 1
      ma_left = 0
    else
      ma_left = 400

    $(this).css({position:"absolute",top:col_heights[add_state],left:"50%","margin-left":ma_left-article_half_width})
    col_heights[add_state] += article_height



timeline_algorithm = (col_heights) ->
  add_state = 0

  $(".tlelm").each ->
    article_height = $(this).height() + 90
    article_half_width = $(this).width()/2
    add_state = minIndex(col_heights)
    
    ma_left = 200
    
    x = col_heights.length #2
    a = 0.5
    b = -0.5
    y = a*x + b
    z = -y + add_state
    ma_left = z * 400
  
    $(this).css({position:"absolute",top:col_heights[add_state],left:"50%","margin-left":ma_left-article_half_width})
    col_heights[add_state] += article_height

  
widthIsUnder850 = () ->
  $(".tlelm").css({
    position:"relative",
    top:"",left:"",
    "margin-left":""
  })
  
  
responsiveWindow = ()->
  $('iframe').each ->
    url = $(this).attr("src")
    $(this).attr("src",url+"?wmode=transparent")

  if $(window).width() > 1250
    timeline_algorithm([30,30,30])
  else if $(window).width() > 850
    timeline_algorithm([30,30])
  else
    timeline_algorithm([30])

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
  #$("#tags").hide()
  responsiveWindow()

  $(window).resize ->
    responsiveWindow()

  $(document).ajaxComplete(ajaxEnd)

# post form init    
#$ ->
#  hidePostFormElms(false)
  
#  $("#new_post textarea").click ->
#    $("#new_post select").show("fade")
#    $("#new_post input[type='file']").show("fade")
#    $("#new_post label").show("fade")
#    $("#new_post textarea").height("150")

# infbtn init
$ ->
  $("#infbtn").hide()
  $(window).bottom({proximity: 0});
  $(window).on 'bottom', ->
    $("#infbtn input[type='submit']").click()

    