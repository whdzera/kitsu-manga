class MangasController < ApplicationController
  before_action :authenticate_user!,
                except: %i[index show by_genre genres search]
  before_action :require_admin, only: %i[create new update edit destroy]
  before_action :set_manga, only: %i[show edit update destroy]

  def to_param
    title.parameterize
  end

  def index
    @mangas = Manga.page(params[:page]).per(6)
  end

  def show
    @chapters = @manga.chapters.order(chapter_number: :desc)
  end

  def new
    @manga = Manga.new
  end

  def edit
  end

  def create
    @manga = Manga.new(manga_params)

    respond_to do |format|
      if @manga.save
        format.html do
          redirect_to @manga, notice: "Manga was successfully created."
        end
        format.json { render :show, status: :created, location: @manga }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @manga.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @manga.update(manga_params)
        format.html do
          redirect_to @manga, notice: "Manga was successfully updated."
        end
        format.json { render :show, status: :ok, location: @manga }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @manga.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @manga.destroy!

    respond_to do |format|
      format.html do
        redirect_to mangas_path,
                    status: :see_other,
                    notice: "Manga was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  def by_genre
    @genre = params[:name]
    @mangas =
      Manga.where("genre LIKE ?", "%#{@genre}%").page(params[:page]).per(6)
  end

  def genres
    @genres = Genre.order(:name)
  end

  def search
    query = params[:q]
    @mangas =
      if query.present?
        Manga.where("title LIKE ?", "%#{query}%").page(params[:page]).per(6)
      else
        Manga.all.page(params[:page]).per(6)
      end

    respond_to { |format| format.html }
  end

  private

  def manga_params
    params.require(:manga).permit(
      :title,
      :alternative_title,
      :status,
      :manga_type,
      :series,
      :author,
      :rating,
      :created_date,
      :genre,
      :image_cover,
      :synopsis
    )
  end

  def set_manga
    @manga =
      if params[:id].to_i.to_s == params[:id]
        Manga.find(params[:id])
      else
        Manga.find_by!(title: params[:id].tr("-", " "))
      end
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this area."
      redirect_to root_path
    end
  end
end
