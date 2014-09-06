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
  
end
