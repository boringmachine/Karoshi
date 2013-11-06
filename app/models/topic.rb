class Topic < ActiveRecord::Base
  attr_accessible :subject,:status
  has_many :group_topics
  has_many :groups, through: :group_topics

  @per_page = 20

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
    paginate :per_page => @per_page, :page => page,
             :conditions => ['subject like ?', "%#{search}%"],
             :order => 'created_at desc'
  end
 
  def self.getGroupTopic(params)
    if params.has_key?(:group)
      topics = GroupTopic.topics(params[:group])
      where(id: topics).search(params[:search], params[:page])
    else
      where(status: nil).search(params[:search], params[:page])
    end
  end
    
end
