class Topic < ActiveRecord::Base
  include SharedMethods

  belongs_to :community
  has_many :posts
  has_many :users , through: :posts
  validates :subject, :length => (1..50)

  @per_page = 20

 
  def self.search(search, page)
    recent.where(deleteflag:nil).where('subject like ?', "%#{search}%").p(page)
  end
 
  def self.getCommunityTopic(params)
    topics = search(params[:search],params[:tpage])
    params.has_key?(:community_id)?topics.where(community_id: params[:community_id]):topics
  end
  
  def self.checkParams(params, user)
    !params.has_key?(:community_id) || CommunityUser.exists?(community_id:params[:community_id], user_id: user.id)
  end
  
end
