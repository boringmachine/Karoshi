class GroupTopic < ActiveRecord::Base
  attr_accessible :group_id, :status, :topic_id
  belongs_to :group
  belongs_to :topic
  has_many :posts
  has_many :users , through: :posts
  
  def self.topics(group_id)
    topics = []
    where(:group_id => group_id).each do |gt|
      topics.push(gt.topic_id)
    end
    topics
  end
  
  def self.deleteSameGroupTopics(topic_id,group_id)
    group_topics = GroupTopic.where(params[:topic],params[:group])
    
    tmp = nil
    group_topics.each do |group_topic|
      tmp = group_topic
      tmp.destroy
    end
    tmp
  end
  
end
