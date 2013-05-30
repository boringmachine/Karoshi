class GroupUsersController < ApplicationController
  # GET /group_users
  # GET /group_users.json
  def index
    @group_users = GroupUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_users }
    end
  end

  # GET /group_users/1
  # GET /group_users/1.json
  def show
    @group_user = GroupUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_user }
    end
  end

  # GET /group_users/new
  # GET /group_users/new.json
  def new
    @group_user = GroupUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_user }
    end
  end

  # GET /group_users/1/edit
  def edit
    @group_user = GroupUser.find(params[:id])
  end

  # POST /group_users
  # POST /group_users.json
  def create
    @group_user = GroupUser.new(params[:group_user])

    respond_to do |format|
      if @group_user.save
        format.html { redirect_to @group_user, notice: 'Group user was successfully created.' }
        format.json { render json: @group_user, status: :created, location: @group_user }
      else
        format.html { render action: "new" }
        format.json { render json: @group_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_users/1
  # PUT /group_users/1.json
  def update
    @group_user = GroupUser.find(params[:id])

    respond_to do |format|
      if @group_user.update_attributes(params[:group_user])
        format.html { redirect_to @group_user, notice: 'Group user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_users/1
  # DELETE /group_users/1.json
  def destroy
    @group_user = GroupUser.find(params[:id])
    @group_user.destroy

    respond_to do |format|
      format.html { redirect_to group_users_url }
      format.json { head :no_content }
    end
  end
end
