class Post < ActiveRecord::Base
  attr_accessible :body, :topic_id, :user_id, :group_id,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  has_attached_file :photo, :styles => { :medium => "400x400>",:small => "100x100>" },
                    :url  => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
  belongs_to :group_topic
  belongs_to :user
  scope :recent, order('created_at desc') 
 
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']
 
  auto_html_for :body do
    html_escape
    image(:width => 400, :height => 400)
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
  end
 
  @per_page = 10
 
  def self.groupposts(group_id,page)
    paginate :per_page => @per_page, :page => page,
             :conditions => ['group_id = ?', group_id],
             :order => "created_at desc"
  end
  
  def self.topicposts(topic_id,page)
    paginate :per_page => @per_page, :page => page,
             :conditions => ['topic_id = ?', topic_id],
             :order => "created_at desc"
  end
 
  def self.groupTopicPosts(group_id, topic_id, page)
    paginate :per_page => @per_page, :page => page,
             :conditions => ['group_id = ? and topic_id = ?', group_id, topic_id],
             :order => "created_at desc"
  end
 
  def self.paging(page)
    paginate :per_page => @per_page, :page => page, :order => 'created_at desc'
  end
 
  def self.search(search, page)
    paginate :per_page => @per_page, :page => page,
             :conditions => ['body like ?', "%#{search}%"],
             :order => 'created_at desc'
  end

  def self.getPosts(search,page,user)
    if search == nil
      groups = user.groups
      Post.where(:group_id => groups).paging(page)
    else
      groups = Group.all
      Post.where(:group_id => groups).search(search, page)
    end
  end


  def self.auto_res(body)
    tmp = body.gsub(/&gt;&gt;([0-9]+)/, '<a href="/posts/\1"> &gt;&gt;\1 </a>')
    tmp = tmp.gsub(/#([a-zA-Z0-9]+)/,'<a href="/posts?search=%23\1">#\1</a>')
    tmp = tmp.gsub(/'/,'&#39;')
    tmp = tmp.gsub(/(\r\n|\n)/,'<br />');
  end

  def self.getBody(topic_id)
    tmp = topicposts(topic_id,1)
    buf = ''
    tmp.each do |post|
      buf += post.body
    end
    buf[0..100]
  end
  
  def self.getDate(topic_id)
    tmp = Post.where(topic_id:topic_id)
    if(tmp.count != 0)
      tmp.last.created_at
    else
      ""
    end
  end

end
