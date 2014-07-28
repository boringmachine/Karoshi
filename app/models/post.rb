class Post < ActiveRecord::Base
  attr_accessible :body, :topic_id, :user_id, :group_id, :group_topic_id, :topic_post_id,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  has_attached_file :photo, :styles => { :medium => "300x300>",:small => "100x100>" },
    :storage => :s3,
    :bucket => 'rocky-wave-100',
    :s3_credentials => "#{Rails.root}/config/s3.yml"
    
  belongs_to :group_topic
  belongs_to :user
  belongs_to :group
  belongs_to :topic
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
             :order => "topic_post_id desc"
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
  
  def self.getPost(params, user)
    groups = user.groups.zip(Group.where(visible: true)).flatten.compact
    Post.where(topic_id: params[:tid], topic_post_id: params[:pid], group_id:groups).first
  end

  def self.getPosts(params,user)
    search = nil
    comment = nil
    
    page = params[:page]
    search = params[:search] if params.has_key?(:search)
    groups = user.groups.zip(Group.where(visible: true)).flatten.compact

    if search.blank?
      Post.where(group_id: groups).paging(page)
    else
      Post.where(group_id: groups).search(search, page)
    end
  end

  def self.getGroupPosts(params)
    if params.has_key?(:topic_id)
      Post.groupTopicPosts(params[:id],params[:topic_id],params[:page])
    else
      Post.groupposts(params[:id],params[:page])
    end
  end
  
  def self.getTopicPosts(params)
    if params.has_key?(:group_id)
      Post.groupTopicPosts(params[:group_id],params[:id],params[:page])
    else
      Post.topicposts(params[:id], params[:page])
    end
  end

  def self.getBody(topic_id)
    page = 1
    tmp = topicposts(topic_id, page)
    buf = ''
    tmp.each do |post|
      buf += post.body
      if buf.length > 100 then break end
    end
    buf[0..100]
  end
  
  def self.getGroupBody(group_id)
    page = 1
    posts = groupposts(group_id, page)
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
  
  def self.moveIds()
    posts = Post.all
    posts.each do |post|
      unless(post.group_id == nil or post.topic_id == nil)
        id = GroupTopic.where(:group_id => post.group_id, :topic_id => post.topic_id).first.id
        post.group_topic_id = id
        post.save
      end
    end
  end
  
  def self.setTopicPostIds()
    posts = Post.all
    tpcounts = Array.new(Topic.count, 0)  
    posts.each do |post|
      unless post.topic_id.blank?
        k = post.topic_id - 1
        tpcounts[k] += 1
        post.topic_post_id = tpcounts[k]
        post.save
      end
    end
  end
  
  def self.getNextTopicPostId(topic_id)
    topicpost = where(topic_id: topic_id).limit(1).order('topic_post_id desc')
    if topicpost.blank?
      1
    else
      topicpost.first.topic_post_id+1
    end
  end
  
  def self.newUserPost(params, user)
    params[:post][:group_topic_id] = GroupTopic.getId(params[:post][:topic_id], params[:post][:group_id])
    params[:post][:topic_post_id]  = Post.getNextTopicPostId(params[:post][:topic_id])
    post = user.posts.new(params[:post])
  end
  
end
