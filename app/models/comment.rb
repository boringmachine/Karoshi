class Comment < ActiveRecord::Base
  attr_accessible :child_id, :parent_id
  belongs_to :parent, :class_name => "Post"
  belongs_to :child,  :class_name => "Post"
  
  def self.createComments(body, post_id)
    comments = body.scan(/>>([0-9]+)/).uniq
    users = Set.new
    comments.each do |comment|
      child_id = comment.first.to_i
      users.add(Post.find(child_id).user)
      Comment.create(parent_id: post_id, child_id: child_id) 
    end
    
    params = {users:users, post_id: post_id, body: body}
    
#    Resque.enqueue(CommentNotifier, params)
    
    users.each do |user|
      from = Post.find(post_id).user
      to = user
      Mailer.notification(from, to,  body, post_id).deliver
    end
    
  end
  
  def self.countRes(child_id)
    Comment.where(child_id:child_id).count
  end
  
end
