class GroupUsersController < ApplicationController
  respond_to :xml, :json

  # GET /group_users
  # GET /group_users.json
  def index
    @group_users = GroupUser.all
    respond_with(@group_users)
  end

  # POST /group_users
  # POST /group_users.json
  def create
    @group_user = GroupUser.new(create_params)
    @group_user.user_id = current_user.id

    flash[:notice] = 'Group user was successfully created.' if @group_user.save
    respond_with(@group_user)
  end

  # DELETE /group_users/1
  # DELETE /group_users/1.json
  def destroy
    @group_user = GroupUser.find(params[:id])
    @group_user.destroy
    respond_with(@group_user)
  end
  
  private
  def create_params
    params.require(:group_user).permit(:group_id)
  end
  
end
