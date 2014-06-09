class Comment < ActiveRecord::Base
  attr_accessible :child_id, :parent_id
  belongs_to :parent, :class_name => "Post"
  belongs_to :child,  :class_name => "Post"
  
  def self.createComments(body, post_id)
    comments = body.scan(/>>([0-9]+)/).uniq
    users = []
    comments.each do |comment|
      child_id = comment.first.to_i
      users.push(Post.find(child_id).user)
      Comment.create(parent_id: post_id, child_id: child_id) 
    end
    
    users.uniq.each do |user|
      from = Post.find(post_id).user
      to = user
      Mailer.notification(from, to,  body).deliver
    end
    
  end
  
  def self.countRes(child_id)
    Comment.where(child_id:child_id).count
  end
  
end
