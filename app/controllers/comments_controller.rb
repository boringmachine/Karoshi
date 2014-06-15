class CommentsController < ApplicationController
  respond_to :xml, :json


  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.save
    respond_with(@comment)
  end

end
