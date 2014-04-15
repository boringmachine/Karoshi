class TagsController < ApplicationController
  respond_to :html, :xml, :json, :js

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.paging(params[:page])
    respond_with(@tags)
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new
    respond_with(@tag)
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])
    respond_with(@tag)
  end

end
