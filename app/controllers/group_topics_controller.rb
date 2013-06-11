class GroupTopicsController < ApplicationController
  respond_to :html, :xml, :json

  # GET /group_topics
  # GET /group_topics.json
  def index
    @group_topics = GroupTopic.all
    respond_with(@group_topics)
  end

  # GET /group_topics/1
  # GET /group_topics/1.json
  def show
    @group_topic = GroupTopic.find(params[:id])
    respond_with(@group_topic)
  end

  # GET /group_topics/new
  # GET /group_topics/new.json
  def new
    @group_topic = GroupTopic.new
    respond_with(@group_topic)
  end

  # GET /group_topics/1/edit
  def edit
    @group_topic = GroupTopic.find(params[:id])
  end

  # POST /group_topics
  # POST /group_topics.json
  def create
    @group_topic = GroupTopic.new(params[:group_topic])
    flash[:notice] = 'Group Topic was successfully created.' if @group_topic.save
    respond_with(@group_topic)
  end

  # PUT /group_topics/1
  # PUT /group_topics/1.json
  def update
    @group_topic = GroupTopic.find(params[:id])
    flash[:notice] = 'Group Topic was successfully updated.' if @group_topic.update_attributes(params[:group_topic])
    respond_with(@group_topic)
  end

  # DELETE /group_topics/1
  # DELETE /group_topics/1.json
  def destroy
    @group_topic = GroupTopic.find(params[:id])
    @group_topic.destroy
    respond_with(@group_topic)
  end
end
