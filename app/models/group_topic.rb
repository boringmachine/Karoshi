class GroupTopic < ActiveRecord::Base
  attr_accessible :group_id, :status, :topic_id
  belong_to :group
  belong_to :topic
end
