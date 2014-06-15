class GroupTopic < ActiveRecord::Base
  attr_accessible :group_id, :topic_id
  belongs_to :group
  belongs_to :topic
  has_many :posts
  has_many :users , through: :posts
  
  def self.groups(topic_id)
    groups = []
    where(topic_id: topic_id).each do |gt|
      groups.push(gt.group_id)
    end
    groups
  end
  
  def self.topics(group_id)
    topics = []
    where(:group_id => group_id).each do |gt|
      topics.push(gt.topic_id)
    end
    topics
  end
 
  def self.notJoinedGroups(topic_id,user_id)
    groups = Group.owngroups(user_id)
    
    njgroups = []
    
    groups.each do |group|
      if where(topic_id: topic_id, group_id: group).empty?
        njgroups.push(group)
      end
    end
    njgroups
  end
  
  def self.joinedGroups(topic_id,user_id)
    gid = GroupUser.groups(user_id)
    groups = Group.where(id: gid)
    
    jgroups = []
    
    groups.each do |group|
      unless where(topic_id: topic_id, group_id: group).empty?
        jgroups.push(group)
      end
    end
    jgroups
  end
  
  
  def self.getFirst(topic_id,group_id)
    where(topic_id:topic_id, group_id:group_id).limit(1).pop
  end
  
  def self.getId(topic_id, group_id)
    getFirst(topic_id, group_id).id
  end
  
  def self.remove_all(id)
    group_topic = find(id)
    tid = group_topic.topic_id
    gid = group_topic.group_id
    GroupTopic.where(topic_id: tid, group_id: gid).update_all("group_id = -1")
  end
end
