module Member
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_member
    
    def index
      # You can fetch member-specific data here
      @user = current_user
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

