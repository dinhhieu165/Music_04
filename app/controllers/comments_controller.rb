class CommentsController < ApplicationController
  before_action :load_comment, only: %i(edit update destroy)

  def create
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def edit
    @commentable_type = @comment.commentable_type
    @commentable_id = @comment.commentable_id
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment.update_attributes comment_params
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment_id = params[:id]
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t("flash.comment_not_exits")
    redirect_to root_path
  end

  def comment_params
    params.require(:comment).permit :content, :commentable_id, :commentable_type
  end
end
