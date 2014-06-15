module ApplicationHelper
  def auto_res(body, tid)
    tmp = body.gsub(/&gt;&gt;([0-9]+)/, '<a href="/posts/?pid=\1'+'&tid='+tid.to_s+ '"> &gt;&gt;\1 </a>')
    tmp = tmp.gsub(/#([a-zA-Z0-9]+)/,'<a href="/posts?search=%23\1">#\1</a>')
    tmp = tmp.gsub(/'/,'&#39;')
    tmp = tmp.gsub(/(\r\n|\n)/,'<br />')
    tmp.html_safe;
  end
  
  def s3(tag)
    tag.gsub("s3.amazonaws.com/rocky-wave-100", "rocky-wave-100.s3.amazonaws.com").html_safe
  end
end
