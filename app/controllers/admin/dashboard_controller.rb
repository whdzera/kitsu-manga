module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

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
      redirect_to admin_account_path
    end

    def users_manag
      @users = User.all.order(created_at: :desc)

      respond_to do |format|
        format.html
        format.json do
          page = params[:page].to_i || 1
          per_page = 10
          offset = (page - 1) * per_page

          users_page = @users.offset(offset).limit(per_page)

          render json: {
                   users:
                     users_page.as_json(
                       only: %i[id username email role created_at],
                       methods: []
                     ),
                   total: @users.count
                 }
        end
      end
    end

    def reports
      @total_mangas = Manga.count
      @total_users = User.count
      @mangas_by_genre = Manga.group(:genre).count
      @users_by_role = User.group(:role).count
    end

    def edit_user
      @user = User.find(params[:id])
    end

    def update_user
      @user = User.find(params[:id])

      # Don't allow admins to edit their own role
      if @user == current_user && user_params[:role] != @user.role
        flash[:alert] = "You cannot change your own admin status."
        redirect_to admin_usermanagement_path
        return
      end

      if @user.update(user_params)
        flash[:notice] = "User was successfully updated."
        redirect_to admin_usermanagement_path
      else
        render :edit_user
      end
    end

    def delete_user
      @user = User.find(params[:id])

      # Don't allow admins to delete themselves
      if @user == current_user
        flash[:alert] = "You cannot delete your own account from here."
        redirect_to admin_usermanagement_path
        return
      end

      @user.destroy
      flash[:notice] = "User was successfully deleted."
      redirect_to admin_usermanagement_path
    end

    private

    def require_admin
      unless current_user.admin?
        flash[:alert] = "You are not authorized to access this area."
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:username, :email, :role, :avatar, :about)
    end
  end
end
