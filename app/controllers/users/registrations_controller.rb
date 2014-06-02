class Users::RegistrationsController < Devise::RegistrationsController
 
  def new
    super
  end
 
  def create
    super
    if Group.first == nil
      group = Group.create(name:"Global Group")
      topic = Topic.getFirstTopic
      GroupTopic.create(group_id:group.id,topic_id:topic.id)
    end
    unless @user.id.blank?
      group = Group.first
      GroupUser.create(user_id: @user.id, group_id: group.id)
      Post.create(user_id: @user.id)
    end
  end
 
end