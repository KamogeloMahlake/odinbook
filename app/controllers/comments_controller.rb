class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html {redirect_to post_path(@post)}
        format.js 
      end
    else
      flash.now[:alert] = "Check the comment form something went horribly wrong."
      redirect_to(post_path(@post))
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user_id == current_user.id 
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to(post_path(@post)) }
        format.js
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
end
