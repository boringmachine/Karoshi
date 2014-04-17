module ApplicationHelper
  def auto_res(body)
    object = thumbnail(body)
    body = makeThumb(body,object)
    tmp = body.gsub(/&gt;&gt;([0-9]+)/, '<a href="/posts/\1"> &gt;&gt;\1 </a>')
    tmp = tmp.gsub(/#([a-zA-Z0-9]+)/,'<a href="/posts?search=%23\1">#\1</a>')
    tmp = tmp.gsub(/'/,'&#39;')
    tmp = tmp.gsub(/(\r\n|\n)/,'<br />')
    tmp.html_safe;
  end
  
  def s3(tag)
    tag.gsub("s3.amazonaws.com/rocky-wave-100", "rocky-wave-100.s3.amazonaws.com").html_safe
  end

  def makeThumb(body,object)
    begin
      if object != nil
        "<a href=" + object.url + ">" +
        "<table class=thumbnail>" +
        "<tr><td><img class=linkimg src="+ object.images.first.source_url + " /></td>" + 
        "<td>"+ object.title + "</td></tr></table></a>" +
        body
      else
        body.gsub(/(https?:\/\/[\S]+)/, '<a href="\1"> \1 </a>')
      end
    rescue Exception => e
      begin
        "<a href=" + object.url + ">" +
        "<table class=thumbnail>" +
        "<tr><td><img class=linkimg src="+ object.images.first.source_url + " /></td>" + 
        "<td>"+ object.title + "</td></tr></table></a>" +
        body
      rescue Exception => e
        body.gsub(/(https?:\/\/[\S]+)/, '<a href="\1"> \1 </a>')
      end
    end
  end

  def thumbnail(body)
    urls = body.scan(/https?:\/\/[\S]+/)
    if urls == []
      return nil
    else 
      begin
        LinkThumbnailer.generate(urls[0])
      rescue Exception => e
        nil
      end
    end
  end

end
