class Comment < ActiveRecord::Base
  attr_accessible :child_id, :parent_id
  belongs_to :parent, :class_name => "Post"
  belongs_to :child,  :class_name => "Post"
  
  def self.createComments(body, post_id)
    comments = body.scan(/>>([0-9]+)/).uniq
    comments.each do |comment|
      child_id = comment[0].to_i
      user = Post.find(child_id).user
      Mailer.notification(user, body).deliver
      Comment.create(parent_id: post_id, child_id: child_id) 
    end
  end
  
  def self.countRes(child_id)
    Comment.where(child_id:child_id).count
  end
  
end
