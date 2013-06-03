class GroupUser < ActiveRecord::Base
  attr_accessible :group_id, :status, :user_id
end
