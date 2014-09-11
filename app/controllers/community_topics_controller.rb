class CommunityTopicsController < ApplicationController
  respond_to :xml, :json

  # GET /community_topics
  # GET /community_topics.json
  def index
    @community_topics = CommunityTopic.all
    respond_with(@community_topics)
  end

  # POST /community_topics
  # POST /community_topics.json
  def create
    @community_topic = CommunityTopic.new(params[:community_topic])
    flash[:notice] = 'Community Topic was successfully created.' if @community_topic.save
    respond_with(@community_topic)
  end

  # DELETE /community_topics/1
  # DELETE /community_topics/1.json
  def destroy
    @community_topic = CommunityTopic.find(params[:id])
    CommunityTopic.remove_all(params[:id]) if current_user.own_communities.find(@community_topic.community_id)
    redirect_to :back
  end
end
