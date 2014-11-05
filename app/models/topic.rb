class Topic < ActiveRecord::Base
  belongs_to :community
  has_many :posts
  has_many :users , through: :posts
  validates :subject, :length => (1..50)

  @per_page = 20

  def self.p(page)
    paginate(page: page, per_page: @per_page)
  end
  
  def self.recent
    order("created_at desc")
  end
  
  def self.getFirstTopic()
    Topic.create(subject:"discussion")
  end

  def self.owner_check(id,user_id)
    topic = find(id)
    communities = topic.communities
    
    flag = false
    communities.each do |community|
      if community.owner_id == user_id
        flag = true
        break
      end
    end
    flag
  end
 
  def self.search(search, page)
    recent.where(deleteflag:nil).where('subject like ?', "%#{search}%").p(page)
  end
 
  def self.getCommunityTopic(params)
    if params.has_key?(:community_id)
      where(community_id: params[:community_id]).search(params[:search],params[:tpage])
    else
      search(params[:search], params[:page])
    end
  end
  
  def self.checkParams(params, user)
    !params.has_key?(:community_id) || CommunityUser.exists?(community_id:params[:community_id], user_id: user.id)
  end
  
end
