class Topic < ActiveRecord::Base
  attr_accessible :subject,:status
  has_many :group_topics
  has_many :groups, through: :group_topics

  def self.owner_check(id,user_id)
    topic = find(id)
    groups = topic.groups
    
    flag = false
    groups.each do |group|
      if group.owner_id == user_id
        flag = true
        break
      end
    end
    flag
  end
 
end
