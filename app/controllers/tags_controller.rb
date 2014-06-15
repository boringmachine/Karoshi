class TagsController < ApplicationController
  respond_to :xml, :json

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.paging(params[:page])
    respond_with(@tags)
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])
    @tag.save
    respond_with(@tag)
  end

end
