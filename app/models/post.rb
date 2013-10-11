class Post < ActiveRecord::Base
  attr_accessible :body, :parent_id, :topic_id, :user_id, :group_id,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  has_attached_file :photo, :styles => { :small => "150x150>" },
                    :url  => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
  belongs_to :group_topic
  belongs_to :user
  scope :recent, order('created_at desc') 
 


  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']
 
  def self.groupposts(group_id,page)
    paginate :per_page => 5, :page => page,
             :conditions => ['group_id = ?', group_id],
             :order => "created_at desc"
  end
  
  def self.topicposts(topic_id,page)
    paginate :per_page => 5, :page => page,
             :conditions => ['topic_id = ?', topic_id],
             :order => "created_at asc"
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
