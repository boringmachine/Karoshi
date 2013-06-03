class GroupUser < ActiveRecord::Base
  attr_accessible :group_id, :status, :user_id
  belong_to :group
  belong_to :user
end
