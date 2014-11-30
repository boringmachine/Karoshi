class CommunityUsersController < ApplicationController
  before_action :set_community_user, only: [:show, :edit, :update, :destroy]

  # GET /community_users
  # GET /community_users.json
  def index
    @community_users = CommunityUser.all
  end

  # GET /community_users/1
  # GET /community_users/1.json
  def show
  end

  # GET /community_users/new
  def new
    @community_user = CommunityUser.new
  end

  # GET /community_users/1/edit
  def edit
  end

  # POST /community_users
  # POST /community_users.json
  def create
    @community_user = CommunityUser.new(community_user_params)

    respond_to do |format|
      if @community_user.save
        format.html { redirect_to @community_user, notice: 'Community user was successfully created.' }
        format.json { render :show, status: :created, location: @community_user }
      else
        format.html { render :new }
        format.json { render json: @community_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /community_users/1
  # PATCH/PUT /community_users/1.json
  def update
    respond_to do |format|
      if @community_user.update(community_user_params)
        format.html { redirect_to @community_user, notice: 'Community user was successfully updated.' }
        format.json { render :show, status: :ok, location: @community_user }
      else
        format.html { render :edit }
        format.json { render json: @community_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /community_users/1
  # DELETE /community_users/1.json
  def destroy
    @community_user.destroy
    respond_to do |format|
      format.html { redirect_to community_users_url, notice: 'Community user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community_user
      @community_user = CommunityUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_user_params
      params.require(:community_user).permit(:user_id, :community_id)
    end
end
