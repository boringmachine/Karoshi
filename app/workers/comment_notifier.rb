class CommentNotifier
  @queue = :comments_queue
  
  def self.perform(users, post_id, body)
    users.each do |user|
      from = Post.find(post_id).user
      to = User.find(user)
      Mailer.notification(from.username, to.email, body, post_id).deliver
    end
  end
  
end