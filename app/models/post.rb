class Post < ActiveRecord::Base
  attr_accessible :body, :parent_id, :topic_id, :user_id, :group_id
  belongs_to :group_topic
  belongs_to :user
  scope :recent, order('created_at desc')
 
  def self.search(search)
    if search
      find(:all, :conditions => ['body LIKE ?', "%#{search}%"])
    else  
      find(:all)
    end
  end



end
