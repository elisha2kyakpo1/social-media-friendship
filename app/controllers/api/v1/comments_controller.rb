module Api
  module V1
    class CommentsController < AuthenticationController
      def create
        @comment = Comment.new(id: params[:post_id], content: params[:content], user: current_user)
        @comment.user = current_user

        if @comment.save
          @comment
        else
          head :unauthorized
        end
      end
    end
  end
end
