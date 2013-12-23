module ApplicationHelper
  def auto_res(body)
    tmp = body.gsub(/&gt;&gt;([0-9]+)/, '<a href="/posts/\1"> &gt;&gt;\1 </a>')
    tmp = tmp.gsub(/#([a-zA-Z0-9]+)/,'<a href="/posts?search=%23\1">#\1</a>')
    tmp = tmp.gsub(/'/,'&#39;')
    tmp = tmp.gsub(/(\r\n|\n)/,'<br />');
  end
  
 def s3Static(tag)
    tag.gsub("s3.amazonaws.com/rocky-wave-100", "rocky-wave-100.s3.amazonaws.com")
  end

end
