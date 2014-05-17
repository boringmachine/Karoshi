class Tag < ActiveRecord::Base
  attr_accessible :count, :name
  has_many :post_tags
  has_many :posts, through: :post_tags
  
  @per_page = 17
  
  def self.paging(page)
    now = Time.now
    lastmonth = now - 1.month
    paginate :per_page => @per_page, :page => page, :order => 'count desc', 
             :conditions => { :updated_at => lastmonth...now }
  end
  
  def self.createTags(body,post_id)
    tags = body.scan(/#[a-zA-Z0-9]+/).uniq
    tags.each do |name|
      name = name.downcase
      tag = where(name: name)
      tag_id = nil
      if tag.empty?
        t = Tag.create(name: name, count: 1)
        tag_id = t.id
      else
        count = tag.first.count + 1
        Tag.find(tag.first).update_attributes(name:name, count: count)
        tag_id = tag.first.id
      end
      PostTag.create(post_id: post_id, tag_id: tag_id) 
    end
  end
  
end
