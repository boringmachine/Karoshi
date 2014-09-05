class Topic < ActiveRecord::Base
  has_many :group_topics
  has_many :groups, through: :group_topics
  validates :subject, :length => (1..50)

  @per_page = 20

  def self.p(page)
    paginate(page: page, per_page: @per_page)
  end
  
  def self.recent
    order("created_at desc")
  end
  
  def self.getFirstTopic()
    if Topic.count == 0
      Topic.create(id:1,subject:"discussion")
    else
      Topic.first
    end
  end

  def self.owner_check(id,user_id)
    topic = find(id)
    groups = topic.groups
    
    flag = false
    groups.each do |group|
      if group.owner_id == user_id
        flag = true
        break
      end
    end
    flag
  end
 
  def self.search(search, page)
    recent.where('subject like ?', "%#{search}%").p(page)
  end
 
  def self.getGroupTopic(params)
    if params.has_key?(:group)
      topics = GroupTopic.topics(params[:group])
      where(id: topics).search(params[:search], params[:page])
    else
      where(status:false).search(params[:search], params[:page])
    end
  end
  
end
