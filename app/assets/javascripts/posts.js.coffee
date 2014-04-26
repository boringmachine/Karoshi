# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  
  setTopicsOption = () ->
    group = $('#post_group_id option:selected').val()
    $.getJSON "../topics.json?group="+group, (data) ->
      $.each data, (i,item) ->
        $('#post_topic_id').append('<option value="'+item.id+'">' + item.subject + '</option>')
  
  setTopicsOption()
  
  $('#post_group_id').change ->
    $('#post_topic_id').empty()
    group = $('#post_group_id option:selected').val()
    setTopicsOption()
    
$ ->
  $.fn.tagcloud.defaults = {
    size: {start: 12, end: 30, unit: 'pt'},
    color: {start: '#fff', end: '#f92'}
  }
  $('.tag_name a').tagcloud();

    
