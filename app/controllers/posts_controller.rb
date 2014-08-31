class PostsController < ApplicationController
  respond_to :html, :xml, :json, :js
   
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.getPosts(params, current_user)
    @tags = Tag.paging(1)
    @groups = Group.recommendGroups(current_user)
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
    @post = Post.newUserPost(params, current_user)
    afterSave(@post) if @post.save
    respond_with(@post)
  end
  
  private
  def afterSave(post)
    flash[:notice] = 'Post was successfully created.' 
    Tag.createTags(post.body, post.id)
    Comment.createComments(post.body, post.id)
  end

end
