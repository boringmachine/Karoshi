class GroupUsersController < ApplicationController
  respond_to :html, :xml, :json, :js

  # GET /group_users
  # GET /group_users.json
  def index
    @group_users = GroupUser.all
    respond_with(@group_users)
  end

  # GET /group_users/1
  # GET /group_users/1.json
  def show
    @group_user = GroupUser.find(params[:id])
    respond_with(@group_user)
  end

  # GET /group_users/new
  # GET /group_users/new.json
  def new
    @group_user = GroupUser.new
    respond_with(@group_user)
  end

  # GET /group_users/1/edit
  def edit
    @group_user = GroupUser.find(params[:id])
  end

  # POST /group_users
  # POST /group_users.json
  def create
    params[:group_user][:user_id] = current_user.id
    @group_user = GroupUser.new(params[:group_user])
    flash[:notice] = 'Group user was successfully created.' if @group_user.save
    respond_with(@group_user)
  end

  # PUT /group_users/1
  # PUT /group_users/1.json
  def update
    params[:group_user][:user_id] = current_user.id
    @group_user = GroupUser.find(params[:id])
    flash[:notice] = 'Group user was succesfuly updated.' if @group_user.update_attributes(params[:group_user])
    respond_with(@group_user)
  end

  # DELETE /group_users/1
  # DELETE /group_users/1.json
  def destroy
    @group_user = GroupUser.find(params[:id])
    @group_user.destroy
    respond_with(@group_user)
  end
end
