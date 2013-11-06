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
    @posts = Group.getPosts(params)
      
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
    @group = current_user.groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    @group[:owner_id] = current_user.id
    flash[:notice] = 'Group was successfully created.' if @group.save
    respond_with(@group)
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = current_user.groups.find(params[:id])
    flash[:notice] = 'Group was successfully updated.' if @group.update_attributes(params[:group])
    respond_with(@group)
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    respond_with(@group)
  end
end
