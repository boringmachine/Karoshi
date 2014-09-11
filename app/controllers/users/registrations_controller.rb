class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters


  def new
    super
  end
 
  def create
    super
    @user.authentication_token = User.create_unique_string
    @user.save
    User.join_first_community(@user.id)
  end
  
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
  
  protected
  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :locale_id, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :email, :locale_id, :password, :password_confirmation, :current_password, :photo)
    end
  end
  
end