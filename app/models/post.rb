class Post < ActiveRecord::Base
  attr_accessible :body, :parent_id, :topic_id, :user_id, :group_id,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  has_attached_file :photo, :styles => { :small => "250x250>" },
                    :url  => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
  belongs_to :group_topic
  belongs_to :user
  scope :recent, order('created_at desc') 
 
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']
 
  @per_page = 10
 
  def self.groupposts(group_id,page)
    paginate :per_page => @per_page, :page => page,
             :conditions => ['group_id = ?', group_id],
             :order => "created_at desc"
  end
  
  def self.topicposts(topic_id,page)
    paginate :per_page => @per_page, :page => page,
             :conditions => ['topic_id = ?', topic_id],
             :order => "created_at asc"
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
    Rinku.auto_link(body.gsub(/>>([0-9]+)/, '<a href="/posts/\1"> >>\1 </a>'))
  end

end
