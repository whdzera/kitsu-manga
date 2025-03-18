module Member
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_member
    
    def index
      @user = current_user
      @bookmarked_mangas = current_user.bookmarked_mangas.page(params[:page]).per(5)

    end

    def bookmarks
      @bookmarked_mangas = current_user.bookmarked_mangas.page(params[:page]).per(5)
    end
    
    private
    
    def require_member
      unless current_user.member?
        flash[:alert] = "You need to be a member to access this area."
        redirect_to root_path
      end
    end
  end
end

