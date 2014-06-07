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

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    respond_with(@post)
  end


  # POST /posts
  # POST /posts.json
  def create
    timediff = Time.now - current_user.posts.last.created_at
    if timediff > 10.seconds
      params[:post][:group_topic_id] = 
        GroupTopic.where(:group_id => params[:post][:group_id], :topic_id => params[:post][:topic_id]).first.id
      @post = current_user.posts.new(params[:post])
      afterSave(@post) if @post.save
      respond_with(@post)
    end
  end
  
  private
  def afterSave(post)
    flash[:notice] = 'Post was successfully created.' 
    Tag.createTags(post.body, post.id)
    Comment.createComments(post.body, post.id)
  end

end
