class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @blog = Blog.find(params[:blog_id])
        @comments = @blog.comments.build(comment_params)
        @comments.user = current_user

        if @comments.save
            redirect_to @blog, notice: 'Comments was successfully created'
        else
            redirect_to @blog, alert: 'Commments could not be saved'
        end
    end

    def comment_params
        params.require(:comment).permit(:body)
    end
end
