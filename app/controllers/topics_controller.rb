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
    Topic.checkParams(params, user) && @topic.save
    respond_with(@topic)
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.deleteflag = true
    @topic.save
    respond_with(@topic)
  end
  
  private
  def create_params
    params.require(:topic).permit(:subject)
  end
end
