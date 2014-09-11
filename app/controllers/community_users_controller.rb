class CommunityUsersController < ApplicationController
  respond_to :xml, :json

  # GET /community_users
  # GET /community_users.json
  def index
    @community_users = CommunityUser.all
    respond_with(@community_users)
  end

  # POST /community_users
  # POST /community_users.json
  def create
    @community_user = CommunityUser.new(create_params)
    @community_user.user_id = current_user.id

    flash[:notice] = 'Community user was successfully created.' if @community_user.save
    respond_with(@community_user)
  end

  # DELETE /community_users/1
  # DELETE /community_users/1.json
  def destroy
    @community_user = CommunityUser.find(params[:id])
    @community_user.destroy
    respond_with(@community_user)
  end
  
  private
  def create_params
    params.require(:community_user).permit(:community_id)
  end
  
end
