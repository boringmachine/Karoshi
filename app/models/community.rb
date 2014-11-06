class Community < ActiveRecord::Base
  include SharedMethods

  has_attached_file :photo, :styles => { :small => "220x220#"},
    :storage => :s3,
    :bucket => 'rocky-wave-100',
    :s3_credentials => "#{Rails.root}/config/s3.yml"

  validates :name, :length => (2..50)
  validates :description, :length => (0..300)
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']

  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  has_many :topics
  has_many :community_users
  has_many :users , through: :community_users

  after_save :finalize
  
  @per_page = 12
  
  
  def self.owncommunities(user_id)
    where(:owner_id => user_id)
  end
  
  def self.search(search, page)
    recent.where('name like ? or description like ?',
               "%#{search}%","%#{search}%").p(page)
  end
  
  def self.getSearch(params)
    params.has_key?(:search) ?
      Community.search(params[:search],params[:page])
      :
      Community.search('',params[:page])
  end
  
  def self.relatedCommunities(community_id)
    result = []
    Community.find(community_id).users.uniq.shuffle.each do |user|
       result.concat(User.find(user.id).communities)
       result = result.uniq
       break if 10 < result.count
    end
    result = result.uniq.shuffle
    delcommunity = Community.find(community_id)
    result.delete(delcommunity)
    result
  end
  
  def self.excludeJoinCommunities(obj_communities,curuser_id)
    user_communities = CommunityUser.communities(curuser_id)
    user_communities.each do |user_community|
      community = Community.find(user_community)
      obj_communities.delete(community)
    end
    obj_communities
  end
  
  
  def self.recommendCommunities(user_id)
    result = []
    CommunityUser.communities(user_id).shuffle.each do |community|
      result.concat(relatedCommunities(community))
      result = result.uniq
      break if 30 < result.count
    end
    result = excludeJoinCommunities(result.uniq, user_id).shuffle
  end
  
  def self.createActionAvailableTime(user)
    Time.now - if user.own_communities.last.blank?
      Time.now - 1.minute
    else
      user.own_communities.last.created_at
    end
  end
  
  def finalize()
    self.topics.create(subject:"discussion")
  end
  
end
