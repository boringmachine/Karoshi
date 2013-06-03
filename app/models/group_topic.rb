class GroupTopic < ActiveRecord::Base
  attr_accessible :group_id, :status, :topic_id
  belongs_to :group
  belongs_to :topic
  has_many :posts
  has_many :users , through: :posts
end
