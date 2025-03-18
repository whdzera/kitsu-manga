class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_manga

  def create
    current_user.bookmarks.create(manga: @manga)
    redirect_to manga_path(@manga), notice: "Manga berhasil di-bookmark."
  end

  def destroy
    current_user.bookmarks.find_by(manga: @manga)&.destroy
    redirect_to manga_path(@manga), notice: "Bookmark dihapus."
  end

  private

  def set_manga
    @manga = Manga.find(params[:manga_id])
  end
end