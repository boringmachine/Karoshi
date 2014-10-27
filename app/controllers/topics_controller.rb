class TopicsController < ApplicationController
  respond_to :html, :xml, :json, :js
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.getCommunityTopic(params)
    respond_with(@topics)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @posts = Post.getTopicPosts(params)
    respond_with(@topic)
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(create_params)
    @topic.community_id = params[:community_id] if params.has_key?(:community_id)
    checkParams(params) && (afterSave(@topic, params) if @topic.save)
    respond_with(@topic)
  end

  private
  def checkParams(params)
    !params.has_key?(:community_id) || CommunityUser.exists?(community_id:params[:community_id], user_id: current_user.id)
  end

  private
  def afterSave(topic, params)
    flash[:notice] = 'Topic was successfully created.'
  end
  
  private
  def create_params
    params.require(:topic).permit(:subject, :community_id)
  end
end
