class Group < ActiveRecord::Base
  attr_accessible :category_id, :description, :name, :visible,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  has_attached_file :photo, :styles => { :small => "220x220#" },
    :storage => :s3,
    :bucket => 'rocky-wave-100',
    :s3_credentials => "#{Rails.root}/config/s3.yml"

  validates :name, :length => (2..50)
  validates :description, :length => (0..300)
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']

  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  has_many :group_topics
  has_many :group_users
  has_many :topics, through: :group_topics
  has_many :users , through: :group_users
  
  @per_page = 12
  
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
      Group.search('',params[:page])
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
