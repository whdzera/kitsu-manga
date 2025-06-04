class ProfilesController < ApplicationController
  def show
    @user = User.find_by!(username: params[:username])
    @bookmarked_mangas =
      Manga
        .joins(:bookmarks)
        .where(bookmarks: { user_id: @user.id })
        .order("bookmarks.created_at DESC")
        .limit(4)
  end
end
