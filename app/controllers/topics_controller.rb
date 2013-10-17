class TopicsController < ApplicationController
  respond_to :html, :xml, :json
  
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = if(params[:group] == nil)
      Topic.all
    else
      topics = GroupTopic.topics(params[:group])
      Topic.find(topics)
    end
    
    respond_with(@topics)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @posts = Post.topicposts(@topic.id,params[:page])
    respond_with(@topic)
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
