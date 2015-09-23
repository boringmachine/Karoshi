class Users::SessionsController < Devise::SessionsController
  def new
    @home_page = true
    super
  end

  def create
    @home_page = true
    super
  end
end