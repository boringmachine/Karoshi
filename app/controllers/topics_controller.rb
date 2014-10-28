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
    @topic = current_user.communities.find(params[:community_id]).topics.new(create_params)
    checkParams(params) && @topic.save
    respond_with(@topic)
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.deleteflag = true
    @topic.save
    respond_with(@topic)
  end

  private
  def checkParams(params)
    !params.has_key?(:community_id) || CommunityUser.exists?(community_id:params[:community_id], user_id: current_user.id)
  end
  
  private
  def create_params
    params.require(:topic).permit(:subject)
  end
end
