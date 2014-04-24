clickflag = on

minIndex = (arr) ->
  i = 0
  tmp = 0
  while(i<arr.length)
    if arr[i] < arr[tmp] then tmp = i
    i++
  return tmp
  

timeline_algorithm = (width) ->
  col_heights = []
  i = 0
  n = Math.round(width/400)
  while(i < n)
    col_heights.push(30)
    i++
  
  add_state = 0

  $(".tlelm").each ->
    article_height = $(this).height() + 90
    article_half_width = $(this).width()/2
    add_state = minIndex(col_heights)
    
    ma_left = 200
    
    x = col_heights.length 
    a = 0.5
    b = -0.5
    y = a*x + b
    z = -y + add_state
    ma_left = z * 400
  
    $(this).css({position:"absolute",top:col_heights[add_state],left:"50%","margin-left":ma_left-article_half_width})
    col_heights[add_state] += article_height

  
reset_timeline = () ->
  $(".tlelm").css({
    position:"relative",
    top:"",left:"",
    "margin-left":""
  })
  
  
responsiveWindow = ()->

  w_width = $(window).width()

  if w_width > 850
    timeline_algorithm(w_width-200)
  else
    reset_timeline()


ajaxEnd = () ->
  responsiveWindow()
  $("#infbtn").hide()
  clickflag = on

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
  responsiveWindow()

  $(window).resize ->
    responsiveWindow()

  $(document).ajaxComplete(ajaxEnd)

$ ->
  clickInfbtn = () ->
    $("#infbtn input[type='image']").click()
  
  $(window).bottom({proximity: 0.1});
  $(window).on 'bottom', ->
    $("#infbtn").show()
    if clickflag is on
      clickflag = off
      setTimeout(clickInfbtn, 500)
