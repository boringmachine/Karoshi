class Tag < ActiveRecord::Base
  attr_accessible :count, :name
  has_many :post_tags
  has_many :posts, through: :post_tags
  
  @per_page = 10
  
  def self.paging(page)
    paginate :per_page => @per_page, :page => page, :order => 'updated_at desc'
  end
  
  def self.createTags(tags,post_id)
    tags.each do |name|
      tag = where(name: name)
      tag_id = nil
      if tag == []
        t = Tag.create(name: name, count: 1)
        tag_id = t.id
      else
        count = tag[0].count + 1
        t = Tag.find(tag[0].id).update_attributes(name:name, count: count)
        tag_id = t.id
      end
      PostTag.create(post_id: post_id, tag_id: tag_id) 
    end
  end
  
  def self.get_tags(body)
    tags = body.scan(/#([a-zA-Z0-9]+)/)
  end
  
end
