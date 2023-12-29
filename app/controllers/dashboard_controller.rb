class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = current_user
        @blogs = @user.blogs
    end
end
