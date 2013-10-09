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

  # GET /topics/1/edit
  def edit
    if Topic.owner_check(params[:id], current_user.id)
      @topic = Topic.find(params[:id])
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    flash[:notice] = 'Topic was successfully created.' if @topic.save
    respond_with(@topic)
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    if Topic.owner_check(params[:id], current_user.id)
      @topic = Topic.find(params[:id])
      flash[:notice] = 'Topic was successfully updated.' if @topic.update_attributes(params[:topic])
      respond_with(@topic)
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    if Topic.owner_check(params[:id], current_user.id)
      @topic = Topic.find(params[:id])
      @topic.destroy
      respond_with(@topic)
    end
  end
end
