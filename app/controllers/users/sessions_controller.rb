class Users::SessionsController < Devise::SessionsController
 
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
  end
end