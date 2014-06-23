class TopicsController < ApplicationController
  respond_to :html, :xml, :json, :js
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.getGroupTopic(params)
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
    @topic = Topic.new(params[:topic])
    afterSave(@topic, params) if @topic.save
    respond_with(@topic)
  end

  private
  def afterSave(topic, params)
    flash[:notice] = 'Topic was successfully created.'
    if params.has_key?(:group_id)
      GroupTopic.create(topic_id:topic.id, group_id: params[:group_id])
    end
  end
end
