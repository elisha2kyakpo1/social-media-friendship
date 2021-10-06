class CommentsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.find(params[:post_id])
  end
  
  
  def create
    @comment = Comment.new(comment_params)
    @posts = Post.all
    @comment.post_id = params[:post_id]
    @comment.user = current_user

    if @comment.save
      redirect_to posts_path, notice: 'Comment was successfully created.'
    else
      redirect_to posts_path, alert: @comment.errors.full_messages.join('. ').to_s
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
