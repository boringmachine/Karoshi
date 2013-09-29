class Post < ActiveRecord::Base
  attr_accessible :body, :parent_id, :topic_id, :user_id, :group_id
  belongs_to :group_topic
  belongs_to :user
  scope :recent, order('created_at desc') 
 
  def self.groupposts(group_id,page)
    paginate :per_page => 5, :page => page,
             :conditions => ['group_id = ?', group_id],
             :order => "created_at desc"
  end
  
  def self.topicposts(topic_id,page)
    paginate :per_page => 5, :page => page,
             :conditions => ['topic_id = ?', topic_id],
             :order => "created_at desc"
  end
 
  def self.groupTopicPosts(group_id, topic_id, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['group_id = ? and topic_id = ?', group_id, topic_id],
             :order => "created_at desc"
  end
 
  def self.search(search, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['body like ?', "%#{search}%"],
             :order => 'created_at desc'
  end


end
