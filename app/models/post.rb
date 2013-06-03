class Post < ActiveRecord::Base
  attr_accessible :body, :parent_id, :topic_id, :user_id
  belongs_to :topic
  belongs_to :user
  scope :recent, order('created_at desc')
end
