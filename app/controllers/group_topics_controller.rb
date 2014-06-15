class GroupTopicsController < ApplicationController
  respond_to :xml, :json

  # GET /group_topics
  # GET /group_topics.json
  def index
    @group_topics = GroupTopic.all
    respond_with(@group_topics)
  end

  # POST /group_topics
  # POST /group_topics.json
  def create
    @group_topic = GroupTopic.new(params[:group_topic])
    flash[:notice] = 'Group Topic was successfully created.' if @group_topic.save
    respond_with(@group_topic)
  end

  # DELETE /group_topics/1
  # DELETE /group_topics/1.json
  def destroy
    @group_topic = GroupTopic.find(params[:id])
    GroupTopic.remove_all(params[:id]) if current_user.own_groups.find(@group_topic.group_id)
    redirect_to :back
  end
end
