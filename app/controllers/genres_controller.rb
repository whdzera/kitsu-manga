class GenresController < ApplicationController
  before_action :require_admin, only: [:create, :destroy]

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to manga_genres_path, notice: "Genre Added"
    else
      redirect_to manga_genres_path, alert: "Failed Added Genre"
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to manga_genres_path, notice: "Genre Deleted"
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
  
  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this area."
      redirect_to root_path
    end
  end

end
