class Comment < ActiveRecord::Base
  belongs_to :parent, :class_name => "Post"
  belongs_to :child,  :class_name => "Post"
  
  def self.createComments(body, post_id)
    comments = body.scan(/>>([0-9]+)/).uniq
    stack = []
    users = Set.new
    comments.each do |comment|
      post = Post.find(post_id)
      child_id = Post.where(:topic_id => post.topic_id, :topic_post_id => comment.first.to_i).first.id
      unless child_id.blank?
        users.add(Post.find(child_id).user.id)
        stack.push Comment.create(parent_id: post_id, child_id: child_id)
      end
    end
    users = users.to_a
    if !Rails.env.development?
      Resque.enqueue(CommentNotifier, users, post_id, body)
    end
    stack
  end
  
  def self.countRes(child_id)
    where(child_id:child_id).count
  end
  
end
