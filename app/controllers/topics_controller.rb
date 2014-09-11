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
    if checkParams(params)
      afterSave(@topic, params) if @topic.save
    end
    respond_with(@topic)
  end

  private
  def checkParams(params)
    if params.has_key?(:community_id)
      CommunityUser.exists?(community_id:params[:community_id], user_id: current_user.id)
    else
      true
    end
  end

  private
  def afterSave(topic, params)
    flash[:notice] = 'Topic was successfully created.'
    if params.has_key?(:community_id)
      CommunityTopic.create(topic_id:topic.id, community_id: params[:community_id])
    end
  end
  
  private
  def create_params
    params.require(:topic).permit(:subject, :status, :community_id)
  end
end
