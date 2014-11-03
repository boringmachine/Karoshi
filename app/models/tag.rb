class Tag < ActiveRecord::Base

  has_many :post_tags
  has_many :posts, through: :post_tags
  
  @per_page = 10
  
  def self.p(page)
    paginate(page: page, per_page: @per_page)
  end
  
  def self.paging(page)
    now = Time.now
    lastmonth = now - 1.month
    order("count desc").where(updated_at: lastmonth...now).p(page)
  end
  
#  def self.createTags(body,post_id)
#    tags = body.scan(/#[a-zA-Z0-9]+/).uniq
#    tags.each do |name|
#      name = name.downcase
#      tag = where(name: name).first
#      tag ||= Tag.create(name: name, count: 0)
#      tag.count += 1
#      tag.save
#      PostTag.create(post_id: post_id, tag_id: tag.id) 
#    end
#  end
  
end
