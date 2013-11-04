class Group < ActiveRecord::Base
  attr_accessible :address, :category_id, :description, :geo, :name, :tel, :url, :visible,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  has_attached_file :photo, :styles => { :small => "160x160>" },
                    :url  => "/assets/groups/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/groups/:id/:style/:basename.:extension"
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']

  belongs_to :category
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  has_many :group_topics
  has_many :group_users
  has_many :topics, through: :group_topics
  has_many :users , through: :group_users
  
  def self.owngroups(user_id)
    where(:owner_id => user_id)
  end
  
  def self.search(search, page)
    paginate :per_page => @per_page, :page => page,
             :conditions => ['name like ? or description like ?',
               "%#{search}%","%#{search}%"],
             :order => 'created_at desc'
  end
  
  def self.getSearch(params)
    if params.has_key?(:search)
      Group.search(params[:search],params[:page])
    else
      Group.search('',1)
    end
  end
  
  def self.getPosts(params)
    if params.has_key?(:topic_id)
      Post.groupTopicPosts(params[:id],params[:topic_id],params[:page])
    else
      Post.groupposts(params[:id],params[:page])
    end
  end
  
end
