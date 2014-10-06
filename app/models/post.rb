class Post < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "300x300>",:small => "100x100>" },
    :storage => :s3,
    :bucket => 'rocky-wave-100',
    :s3_credentials => "#{Rails.root}/config/s3.yml"
    
  belongs_to :community_topic
  belongs_to :user
  belongs_to :community
  belongs_to :topic
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comment_parent, :foreign_key => "parent_id", :class_name => "Comment"
  has_many :comment_child,  :foreign_key => "child_id",  :class_name => "Comment"
  has_many :childs, :class_name => "Post", :through => :comment_parent, :source => :child
  has_many :parents, :class_name => "Post",:through => :comment_child, :source => :parent
 
  validates :body, :length => (0..500)
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']
 
  auto_html_for :body do
    html_escape
    youtube(:width => 300, :height => 300)
    link :target => "_blank", :rel => "nofollow"
  end
 
  @per_page = 20
 
  def self.recent
    order('created_at desc')
  end
 
  def self.p(page)
    paginate(page: page, per_page: @per_page)
  end
 
  def self.communityposts(community_id,page)
    recent.where(community_id: community_id).p(page)
  end
  
  def self.topicposts(topic_id,page)
    order("topic_post_id desc").where(topic_id: topic_id).p(page)
  end
 
  def self.communityTopicPosts(community_id, topic_id, page)
    recent.where(community_id: community_id, topic_id: topic_id).p(page)
  end
 
  def self.paging(page)
    recent.p(page)
  end
 
  def self.search(search, page)
    recent.where('body like ?', "%#{search}%").p(page)
  end
  
  def self.getPost(params, user)
    communities = user.communities
    Post.where(topic_id: params[:tid], topic_post_id: params[:pid], community_id:communities).first
  end

  def self.getPosts(params,user)
    search = nil
    comment = nil
    
    page = params[:page]
    search = params[:search] if params.has_key?(:search)
    communities = user.communities

    if search.blank?
      Post.where(community_id: communities).paging(page)
    else
      communities = user.communities.zip(Community.where(visible: true)).flatten.compact
      Post.where(community_id: communities).search(search, page)
    end
  end

  def self.getCommunityPosts(params)
    if params.has_key?(:topic_id)
      Post.communityTopicPosts(params[:id],params[:topic_id],params[:page])
    else
      Post.communityposts(params[:id],params[:page])
    end
  end
  
  def self.getTopicPosts(params)
    if params.has_key?(:community_id)
      Post.communityTopicPosts(params[:community_id],params[:id],params[:page])
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
  
  def self.getCommunityBody(community_id)
    page = 1
    posts = communityposts(community_id, page)
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
  
  def self.getNextTopicPostId(topic_id)
    tp = where(topic_id: topic_id).limit(1).order('topic_post_id desc')
    if tp.blank?
      1
    else
      tp.first.topic_post_id+1
    end
  end
  
  def self.newUserPost(params, user)
    create_params = params.require(:post).permit(:body, :community_id, :topic_id, :photo)
    post = user.posts.new(create_params)
    post.community_topic_id = CommunityTopic.getId(params[:post][:topic_id], params[:post][:community_id])
    post.topic_post_id = Post.getNextTopicPostId(params[:post][:topic_id])
    post
  end
  
end
