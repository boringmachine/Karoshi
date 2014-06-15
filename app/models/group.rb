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
  
  def self.relatedGroups(group_id)
    result = []
    Group.find(group_id).users.uniq.shuffle.each do |user|
       result.concat(User.find(user.id).groups)
       result = result.uniq
       break if 10 < result.count
    end
    result = result.uniq.shuffle
    delgroup = Group.find(group_id)
    result.delete(delgroup)
    excludeInvisibleGroups(result)
  end
  
  def self.excludeJoinGroups(obj_groups,curuser_id)
    user_groups = GroupUser.groups(curuser_id)
    user_groups.each do |user_group|
      group = Group.find(user_group)
      obj_groups.delete(group)
    end
    obj_groups
  end
  
  def self.excludeInvisibleGroups(groups)
    obj_groups = []
    groups.each do |group|
      obj_groups.push(group) if group.visible
    end
    obj_groups
  end
  
  def self.recommendGroups(user_id)
    result = []
    GroupUser.groups(user_id).shuffle.each do |group|
      result.concat(relatedGroups(group))
      result = result.uniq
      break if 30 < result.count
    end
    result = excludeJoinGroups(result.uniq, user_id).shuffle
    result = excludeInvisibleGroups(result)
  end
  
end
