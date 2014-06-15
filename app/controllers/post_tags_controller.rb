class PostTagsController < ApplicationController
  respond_to :xml, :json

  # GET /post_tags
  # GET /post_tags.json
  def index
    @post_tags = PostTag.all
    respond_with(@post_tags)
  end


  # POST /post_tags
  # POST /post_tags.json
  def create
    @post_tag = PostTag.new(params[:post_tag])
    @post_tag.save
    respond_with(@post_tag)
  end

end
