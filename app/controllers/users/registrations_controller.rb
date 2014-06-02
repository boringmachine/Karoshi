class Users::RegistrationsController < Devise::RegistrationsController
 
  def new
    super
  end
 
  def create
    super
    group = if Group.first == nil
      Group.create(name:"Global Group")
    else
      Group.first
    end
    GroupUser.create(user_id:@user.id,group_id:group.id)
    topic = Topic.getFirstTopic
    GroupTopic.create(group_id:group.id,topic_id:topic.id)
    Post.create(:user_id => @user.id)
  end
 
end