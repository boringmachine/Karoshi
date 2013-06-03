class GroupTopicsController < ApplicationController
  # GET /group_topics
  # GET /group_topics.json
  def index
    @group_topics = GroupTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_topics }
    end
  end

  # GET /group_topics/1
  # GET /group_topics/1.json
  def show
    @group_topic = GroupTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_topic }
    end
  end

  # GET /group_topics/new
  # GET /group_topics/new.json
  def new
    @group_topic = GroupTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_topic }
    end
  end

  # GET /group_topics/1/edit
  def edit
    @group_topic = GroupTopic.find(params[:id])
  end

  # POST /group_topics
  # POST /group_topics.json
  def create
    @group_topic = GroupTopic.new(params[:group_topic])

    respond_to do |format|
      if @group_topic.save
        format.html { redirect_to @group_topic, notice: 'Group topic was successfully created.' }
        format.json { render json: @group_topic, status: :created, location: @group_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @group_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_topics/1
  # PUT /group_topics/1.json
  def update
    @group_topic = GroupTopic.find(params[:id])

    respond_to do |format|
      if @group_topic.update_attributes(params[:group_topic])
        format.html { redirect_to @group_topic, notice: 'Group topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_topics/1
  # DELETE /group_topics/1.json
  def destroy
    @group_topic = GroupTopic.find(params[:id])
    @group_topic.destroy

    respond_to do |format|
      format.html { redirect_to group_topics_url }
      format.json { head :no_content }
    end
  end
end
