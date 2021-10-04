class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new

    timeline_posts

    respond_to do |format|
      format.html
      format.json { render :json => timeline_posts }
    end

  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post
    else
      timeline_posts
      render json: index
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
