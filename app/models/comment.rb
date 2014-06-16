class Comment < ActiveRecord::Base
  attr_accessible :child_id, :parent_id
  belongs_to :parent, :class_name => "Post"
  belongs_to :child,  :class_name => "Post"
  
  def self.createComments(body, post_id)
    comments = body.scan(/>>([0-9]+)/).uniq
    users = Set.new
    comments.each do |comment|
      post = Post.find(post_id)
      child_id = Post.where(:topic_id => post.topic_id, :topic_post_id => comment.first.to_i).first.id
      unless child_id.blank?
        users.add(Post.find(child_id).user.id)
        Comment.create(parent_id: post_id, child_id: child_id)
      end 
    end
    
    users = users.to_a
    Resque.enqueue(CommentNotifier, users, post_id, body)
    
  end
  
  def self.countRes(child_id)
    Comment.where(child_id:child_id).count
  end
  
  def self.refleshComments()
    Comment.delete_all()
    Post.delete_all(['body like ?', "%>>%"])

  end
end
