class PostsController < ApplicationController
  respond_to :html, :xml, :json
  # GET /posts
  # GET /posts.json
  def index
    @posts = current_user.posts.recent
    respond_with(@posts)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
#    @post = Post.find(params[:id])
    @post = current_user.posts.find(params[:id])
    respond_with(@post)
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    respond_with(@post)
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(params[:post])
#    @post = Post.new(params[:post])
#    @post[:user_id] = current_user.id;
    flash[:notice] = 'Post was successfully created.' if @post.save
    respond_with(@post)
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = current_user.posts.find(params[:id])
    if(@post[:user_id] == current_user.id)
      flash[:notice] = 'Post was successfully updated.' if @post.update_attributes(params[:post])
    end
    respond_with(@post)
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post[:user_id] == current_user.id
    respond_with(@post)
  end
end
