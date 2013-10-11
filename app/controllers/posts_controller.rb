class PostsController < ApplicationController
  respond_to :html, :xml, :json
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.getPosts(params[:search],params[:page])
    respond_with(@posts)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = current_user.posts.find(params[:id])
    respond_with(@post)
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    respond_with(@post)
  end


  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(params[:post])
    flash[:notice] = 'Post was successfully created.' if @post.save
    respond_with(@post)
  end


end
