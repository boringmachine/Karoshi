class Post < ActiveRecord::Base
  attr_accessible :body, :parent_id, :topic_id, :user_id
  belong_to :topic
  belong_to :user
end
