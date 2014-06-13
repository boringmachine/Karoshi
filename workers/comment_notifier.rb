class CommentNotifier
  @queue = :mailer_queue
  
  def self.perform(params)
    params[:users].each do |user|
      from = Post.find(params[:post_id]).user
      to = user
      Mailer.notification(from, to,  params[:body], params[:post_id]).deliver
    end
  end
  
end