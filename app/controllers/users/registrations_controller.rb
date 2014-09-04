class Users::RegistrationsController < Devise::RegistrationsController
 
  def new
    super
  end
 
  def create
    super
    @user.authentication_token = User.create_unique_string
    @user.save
    User.join_first_group(@user)
  end
  
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
end