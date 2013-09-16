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
end
