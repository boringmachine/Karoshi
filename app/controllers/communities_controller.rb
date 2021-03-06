class CommunitiesController < ApplicationController
  respond_to :html, :xml, :json, :js

  # GET /communities
  # GET /communities.json
  def index
    @communities = Community.search(params[:search], params[:page])
    respond_with(@communities)
  end

  # GET /communities/1
  # GET /communities/1.json
  def show
    @community = Community.find(params[:id])
    @rcommunities = Community.relatedCommunities(params[:id])
    @posts = Post.getCommunityPosts(params)
    respond_with(@community)
  end

  # GET /communities/new
  # GET /communities/new.json
  def new
    @community = Community.new
    respond_with(@community)
  end

  # GET /communities/1/edit
  def edit
    @community = current_user.own_communities.find(params[:id])
  end

  # POST /communities
  # POST /communities.json
  def create
    @community = Community.new(create_params)
    @community[:owner_id] = current_user.id
    Community.createActionAvailableTime(current_user) > 30.seconds and @community.save
    respond_with(@community)
  end

  # PUT /communities/1
  # PUT /communities/1.json
  def update
    @community = current_user.own_communities.find(params[:id])
    flash[:notice] = 'Community was successfully updated.' if @community.update_attributes(update_params)
    respond_with(@community)
  end
  
  private
  def create_params
    params.require(:community).permit(:name, :description, :photo)
  end
  
  private
  def update_params
    params.require(:community).permit(:name, :description, :photo)
  end
  
end
