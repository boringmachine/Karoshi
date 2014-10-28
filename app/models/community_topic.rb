class CommunityTopic < ActiveRecord::Base
  belongs_to :community
  belongs_to :topic
  has_many :posts
  has_many :users , through: :posts
  
  def self.communities(topic_id)
    communities = []
    where(topic_id: topic_id).each do |gt|
      communities.push(gt.community_id)
    end
    communities
  end
  
  def self.topics(community_id)
    topics = []
    where(:community_id => community_id).each do |gt|
      topics.push(gt.topic_id)
    end
    topics
  end
 

  

  
  
  def self.getFirst(topic_id,community_id)
    where(topic_id:topic_id, community_id:community_id).limit(1).first
  end
  
  def self.getId(topic_id, community_id)
    getFirst(topic_id, community_id).id
  end
  
  def self.remove_all(id)
    community_topic = find(id)
    topic_id = community_topic.topic_id
    community_id = community_topic.community_id
    CommunityTopic.delete_all(topic_id: topic_id, community_id: community_id)
  end
end
