class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  def self.groups(user_id)
    groups = []
    where(user_id: user_id).each do |gu|
      groups.push(gu.group_id)
    end
    groups
  end
  
  def self.users(group_id)
    users = []
    where(group_id: group_id).each do |group|
      users.push(group.user_id)
    end
    users
  end
  
  def self.getGroupUser(user_id, group_id)
      where(group_id: group_id, user_id: user_id)
  end
  
  def self.exist(user_id, group_id)
    if getGroupUser(user_id, group_id) == []
      false
    else
      true
    end
  end
    
  def self.weight(group1_id, group2_id)
    g1 = where(group_id: group1_id)
    c1 = g1.count
    
    g2 = where(group_id: group2_id)
    c2 = g2.count
    
    count = 0
    
    n = c1 < c2 ? c1 : c2
    m = c1 > c2 ? c1 : c2
    m = m == 0  ?  1 : m
    
    if(0 < n)
      for i in 0...n
        if g1[i].user_id == g2[i].user_id then count+=1 end
      end
    end
    
    (count*100)/m
  end
  
end
