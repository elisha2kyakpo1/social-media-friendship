module Api
  module V1
    class PostsController < AuthenticationController
      def index
        @posts = Post.all.order(created_at: :desc).includes(:comments)
      end
    end
  end
end
