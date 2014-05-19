class Post < ActiveRecord::Base
  attr_accessible :body, :topic_id, :user_id, :group_id, :comment_count,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  has_attached_file :photo, :styles => { :medium => "300x300>",:small => "100x100>" },
    :storage => :s3,
    :bucket => 'rocky-wave-100',
    :s3_credentials => "#{Rails.root}/config/s3.yml"
    
  belongs_to :group_topic
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comment_parent, :foreign_key => "parent_id", :class_name => "Comment"
  has_many :comment_child,  :foreign_key => "child_id",  :class_name => "Comment"
  has_many :childs, :class_name => "Post", :through => :comment_parent, :source => :child
  has_many :parents, :class_name => "Post",:through => :comment_child, :source => :parent

  scope :recent, order('created_at desc') 
 
  validates :body, :length => (0..500)
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']
 
  auto_html_for :body do
    html_escape
    youtube(:width => 300, :height => 300)
    link :target => "_blank", :rel => "nofollow"
  end
 
  @per_page = 20
 
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
      Post.search(search, page)
    end
  end


  def self.getBody(topic_id)
    tmp = topicposts(topic_id,1)
    buf = ''
    tmp.each do |post|
      buf += post.body
      if buf.length > 100 then break end
    end
    buf[0..100]
  end
  
  def self.getGroupBody(group_id)
    posts = groupposts(group_id,1)
    buf = ''
    posts.each do |post|
      buf += post.body
      if buf.length > 200 then break end
    end
    buf[0..200]
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
