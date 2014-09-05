class GroupsController < ApplicationController
  respond_to :html, :xml, :json, :js

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.getSearch(params)
    respond_with(@groups)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @rgroups = Group.relatedGroups(params[:id])
    @posts = Post.getGroupPosts(params)
    respond_with(@group)
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
    respond_with(@group)
  end

  # GET /groups/1/edit
  def edit
    @group = current_user.own_groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(create_params)
    @group[:owner_id] = current_user.id
    afterSave(@group) if @group.save
    respond_with(@group)
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = current_user.own_groups.find(params[:id])
    flash[:notice] = 'Group was successfully updated.' if @group.update_attributes(update_params)
    respond_with(@group)
  end

  private
  def afterSave(group)
    flash[:notice] = 'Group was successfully created.' 
    GroupTopic.create(topic_id:Topic.getFirstTopic.id, group_id:group.id)
  end
  
  private
  def create_params
    params.require(:group).permit(:name, :description, :visible, :photo)
  end
  
  private
  def update_params
    params.require(:group).permit(:name, :description, :visible, :photo)
  end

end
