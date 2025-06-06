class ProfilesController < ApplicationController
  def show
    @user = User.find_by!(username: params[:username])
    @bookmarked_mangas =
      Manga
        .joins(:bookmarks)
        .where(bookmarks: { user_id: @user.id })
        .order("bookmarks.created_at DESC")
        .limit(4)

    @profile = User.find_by(username: params[:username])

    if @profile.nil?
      redirect_to root_path, alert: "User not found."
      return
    end
    @profile_comments =
      ProfileComment.where(profile_user_id: @profile.id).order(
        created_at: :desc
      )
  end
end
