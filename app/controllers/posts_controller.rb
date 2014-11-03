class PostsController < ApplicationController
  respond_to :html, :xml, :json, :js
   
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.getPosts(params, current_user)
    @tags = Tag.paging(1)
    @communities = Community.recommendCommunities(current_user)
    respond_with(@posts)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    respond_with(@post)
  end
  
  # GET /posts/1/1
  # GET /posts/1/1.json
  def view
    @post = Post.getPost(params, current_user)
    respond_with(@post)
  end

  # POST /posts
  # POST /posts.json
  def create
    if Post.checkParams(current_user, params[:post][:topic_id])
      @post = Post.newUserPost(params, current_user)
      flash[:notice] = 'Post was successfully created.' if @post.save
      respond_with(@post)
    end
  end
  
  private
  def create_params
    params.require(:post).permit(:body, :topic_id, :photo)
  end
end
