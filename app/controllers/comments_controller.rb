class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:new, :create, :index]  # Ensure post context is set for new, create, and index actions
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_comment, only: [:edit, :update, :destroy]

  # GET /posts/:post_id/comments
  def index
    @comments = @post.comments  # Display comments for the specific post
  end

  # GET /posts/:post_id/comments/new
  def new
    @comment = @post.comments.new  # Initialize a new comment for the given post
  end

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.new(comment_params)  # Create the comment (without user_id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_comments_path(@post), notice: "Comment was successfully created." }  # Redirect to post's comment list
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_comment_path(@post, @comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to post_comments_path(@post), status: :see_other, notice: "Comment was successfully destroyed." }  # Redirect back to post's comment list
      format.json { head :no_content }
    end
  end

  private

  # Set the post based on the post_id parameter
  def set_post
    @post = Post.find(params[:post_id])  # Retrieve the post based on `post_id`
  end

  # Set the comment based on the id parameter
  def set_comment
    @comment = Comment.find(params[:id])  # Retrieve the specific comment
  end

  # Authorize the comment for editing, updating, or destroying
  def authorize_comment
    authorize @comment  # Pundit will check if the current_user can edit/update/destroy the comment
  end

  # Strong parameters for creating/updating a comment
  def comment_params
    params.require(:comment).permit(:content, :rating)  # Only permit the content and rating fields
  end
end
