# timeline view class
class Timeline
  constructor: (@name) -> 

  timeline : (w_width, e_width, t, top) ->
  
    minIndex = (arr) ->
      i = 0
      tmp = 0
      while(i<arr.length)
        if arr[i] < arr[tmp] then tmp = i
        i++
      return tmp
  
  
    col_heights = []
    i = 0
    n = Math.round(w_width / (e_width + t))
    while(i < n)
      col_heights.push(top)
      i++
  
    add_state = 0

    $(@name).each ->
      article_height = $(this).height() + t
      w = e_width
      add_state = minIndex(col_heights)
        
      x = col_heights.length 
      y = -0.5*x + (add_state+0.5)
      ma_left = y *(w + t)
  
      $(this).css({position:"absolute",top:col_heights[add_state],left:"50%","margin-left":ma_left-w/2})
      col_heights[add_state] += article_height

  
  reset_timeline : () ->
    $(@name).css({
      position:"relative",
      top:"",left:"",
      "margin-left":""
    })


#infbtn flag init
clickflag = on  

# responsive design init
responsiveWindow = ()->

  w_width = $(window).width()
  e_width = 310
  timeline = new Timeline ".tlelm"

  if w_width > 850
    timeline.timeline(w_width-200, e_width, 90, 30)
  else
    timeline.reset_timeline()

frameTransparent = () ->
  $('iframe').each ->
    url = $(this).attr("src")
    $(this).attr("src",url+"?wmode=transparent")


# ajax complete init
ajaxEnd = () ->
  responsiveWindow()
  frameTransparent()
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
  frameTransparent()

  $(window).resize ->
    responsiveWindow()

  $(document).ajaxComplete(ajaxEnd)


# infbtn init
$ ->
  clickInfbtn = () ->
    $("#infbtn input[type='image']").click()
  
  $(window).bottom({proximity: 0.1});
  $(window).on 'bottom', ->
    $("#infbtn").show()
    if clickflag is on
      clickflag = off
      setTimeout(clickInfbtn, 500)
