class TagsController < ApplicationController
  respond_to :xml, :json

  # GET /tags
  # GET /tags.json
  def index
    @tags ||= Tag.paging(params[:page])
    respond_with(@tags)
  end

end
