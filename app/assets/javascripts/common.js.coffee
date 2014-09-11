# timeline view class
class Timeline
  constructor: (@name) -> 

  timeline : (w_width, e_width, top) ->
  
    minIndex = (arr) ->
      tmp = 0
      for i in [0...arr.length]
        if arr[i] < arr[tmp] then tmp = i
        
      return tmp
  
  
    col_heights = []
    t = Math.ceil(e_width/3.5)
    n = Math.round(w_width / (e_width + t))
    for i in [0...n]
      col_heights.push(top)
  
    add_state = 0

    $(@name).each ->
      article_height = $(this).height() + t 
      w = e_width
      k = minIndex(col_heights)
        
      x = col_heights.length 
      y = -0.5*x + (k + 0.5)
      ma_left = y * (w + t)
  
      $(this).css({position:"absolute",top:col_heights[k], left:"50%","margin-left":ma_left-w/2})
      col_heights[k] += article_height

  
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

  if w_width > 1200
    timeline.timeline(1200, e_width, 30)
    $("#about").width(700)
  else if w_width > 850
    timeline.timeline(800, e_width, 30)
    $("#about").width(500)
  else
    timeline.reset_timeline()
    $("#about").width(300)
    

frameTransparent = () ->
  $('iframe').each ->
    url = $(this).attr("src")
    if $(this).attr("data-transparent") != "1"
      $(this).attr {
        "src" : url+"?wmode=transparent"
        "data-transparent" : "1"
      }


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
		sel = if val is "1" then "/posts"
		else if val is "2" then "/communities"
		else "/topics"

		$("#search_post form").attr("action",sel)
		

#	sidebar init	
$ ->
  menubool = true
  $("#sidebar").hide()
  $("#menu").click ->
    if menubool is on
      $("#sidebar").toggle("drop",200)
    else
      $("#sidebar").toggle("drop",200)
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
    $("#infbtn input[type='image']").submit()
  
  $("#infbtn").hide()
  $(window).bottom({proximity: 0.1});
  $(window).on 'bottom', ->
    $("#infbtn").show()
    if clickflag is on
      clickflag = off
      setTimeout(clickInfbtn, 500)

# post textarea init      
$ ->
  $('#new_post_section textarea').maxlength()
  $('#new_post_section textarea').bind 'keydown keyup keypress change', ->
    count = 500 - $(this).val().length
    $('.count_char').html(count)
