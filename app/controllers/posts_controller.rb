class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all

    # Search by description
    if params[:search].present?
      @posts = @posts.search_by_description(params[:search])
    end

    # Search by tags
    if params[:tag_search].present?
      @posts = @posts.search_by_tag(params[:tag_search])
    end

    # Authorization is not needed here as we only list posts
  end

  # GET /posts/1 or /posts/1.json
  def show
    # Authorize the user for the show action
    authorize @post
  end

  # GET /posts/new
  def new
    @post = Post.new
    # Authorization for new post creation
    authorize Post
  end

  # GET /posts/1/edit
  def edit
    # Authorize the user for the edit action
    authorize @post
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    # Authorize the user for creating a new post
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    # Authorize the user for the update action
    authorize @post

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    # Authorize the user for the destroy action
    authorize @post

    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Authorization logic for specific actions
    def authorize_post
      authorize @post
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :description, :tags, :owner_id)
    end
end
