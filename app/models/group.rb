class Group < ActiveRecord::Base
  attr_accessible :category_id, :description, :name, :visible,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  has_attached_file :photo, :styles => { :small => "220x220#"},
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
  
  def self.relatedGroups(group_id)
    result = []
    Group.find(group_id).users.uniq.each do |user|
       result.concat(User.find(user.id).groups)
       result = result.uniq
       break if 100 < result.count
    end
    result.uniq
  end
  
  def excludeJoinGroups(obj_groups,curuser_id)
    user_groups = GroupUser.groups(curuser_id)
    user_groups.each do |user_group|
      group = Group.find(user_group)
      obj_groups.delete(group)
    end
    obj_groups
  end
  
  def self.recommendGroups(user_id)
    GroupUser.groups(user_id).each do |group|
      result = []
      result.concat(relatedGroups(group))
      result = result.uniq
      break if 300 < result.count
    end
    excludeJoinGroups(result.uniq)
  end
  
end
