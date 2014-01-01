class GroupUser < ActiveRecord::Base
  attr_accessible :group_id, :status, :user_id
  belongs_to :group
  belongs_to :user

  def self.groups(user_id)
    groups = []
    where(user_id: user_id).each do |gu|
      groups.push(gu.group_id)
    end
    groups
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
  
  #TODO http://philogb.github.io/jit/static/v20/Jit/Examples/Hypertree/example2.html
  
  def self.weight(group1_id, group2_id)
    g1 = where(group_id: group1_id)
    c1 = g1.count
    
    g2 = where(group_id: group2_id)
    c2 = g2.count
    
    count = 0
    
    n = c1 < c2 ? c1 : c2
    
    if(0 < n)
      for i in 0...(n-1)
        if g1[i].user_id == g2[i].user_id then count+=1 end
      end
    end
    
    (count*100)/n
  end
  
  def self.weightAll()
    data = [];
    n = Group.count
    
    for i in 1...n
      node = {id: i,name: i, adjacencies:[]} 
      for j in 1...n
        unless i==j
          w = weight(i,j)
          adj = {nodeTo:j, data:{weight:w}}
          node[:adjacencies].push(adj)
        end
      end
      data.push(node)
    end
    data
  end
  
end
