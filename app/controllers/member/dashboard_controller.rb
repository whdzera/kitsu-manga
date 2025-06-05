module Member
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_member

    def index
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update(user_params)
        flash[:notice] = "Profile updated successfully."
      else
        flash[:alert] = "Failed to update profile."
      end
      redirect_to member_dashboard_path
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :avatar)
    end

    def require_member
      unless current_user.member?
        flash[:alert] = "You need to be a member to access this area."
        redirect_to root_path
      end
    end
  end
end
