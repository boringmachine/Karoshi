class PostsController < ApplicationController
  respond_to :html, :xml, :json, :js
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.getPosts(params[:search], params[:page], current_user)
    @tags = Tag.paging(1)
    respond_with(@posts)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
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
    if @post.save
      flash[:notice] = 'Post was successfully created.' 
      Tag.createTags(Tag.get_tags(@post.body), @post.id)
    end
    respond_with(@post)
  end


end
