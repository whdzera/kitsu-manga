class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_manga, only: [:create, :destroy]

  def index
    @bookmarked_mangas = current_user.bookmarked_mangas.page(params[:page]).per(8)
  end

  def create
    current_user.bookmarks.create(manga: @manga)
    redirect_to manga_path(@manga), notice: "Manga has bookmarked."
  end

  def destroy
    current_user.bookmarks.find_by(manga: @manga)&.destroy
    redirect_to manga_path(@manga), notice: "Manga has unBookmarked"
  end

  private

  def set_manga
    @manga = Manga.find(params[:manga_id])
  end
end