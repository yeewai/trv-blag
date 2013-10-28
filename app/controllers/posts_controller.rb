class PostsController < ApplicationController
  before_filter :authorize, :except => ["index", "show"]
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order("created_at desc").paginate(:page => params[:page], :per_page => 5)
  end
  
  def archive
    @posts = Post.order("created_at desc")
  end
  
  def tagged
    @tag = Tag.find_by_slug params[:tag]
    if @tag
      @posts = @tag.posts.order("created_at desc").paginate(:page => params[:page], :per_page => 5)
    else
      @posts = nil
    end
    render "index"
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find_by_slug(params[:id])
    @comment = Comment.new
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @photos = Photo.order("created_at desc")
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find_by_slug(params[:id])
    @photos = Photo.order("created_at desc")
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find_by_slug(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
