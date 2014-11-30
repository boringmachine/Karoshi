class CommunityUser < ActiveRecord::Base
  include SharedMethods

  belongs_to :community
  belongs_to :user

  def self.communities(user_id)
    communities = []
    where(user_id: user_id).each do |gu|
      communities.push(gu.community_id)
    end
    communities
  end
  
  def self.users(community_id)
    users = []
    where(community_id: community_id).each do |community|
      users.push(community.user_id)
    end
    users
  end
  
  def self.getCommunityUser(user_id, community_id)
    where(community_id: community_id, user_id: user_id)
  end
  
end
