class TopicsController < ApplicationController
  respond_to :html, :xml, :json
  
  
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
    
    @posts = if params.has_key?(:group_id)
      Post.groupTopicPosts(params[:group_id],params[:id],params[:page])
    else
      Post.topicposts(params[:id], params[:page])
    end
    respond_with(@topic,@posts)
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
    respond_with(@topic)
  end


  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    flash[:notice] = 'Topic was successfully created.' if @topic.save
    if params.has_key?(:group_id)
      GroupTopic.create(topic_id:@topic.id, group_id: params[:group_id])
    end
    respond_with(@topic)
  end



end
