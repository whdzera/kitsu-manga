class MangasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :require_admin, only: [:create, :new, :update, :edit, :destroy]
  before_action :set_manga, only: [:show, :edit, :update, :destroy]

  def to_param
    title.parameterize 
  end

  # GET /mangas or /mangas.json
  def index
    @mangas = Manga.page(params[:page]).per(6)
  end

  # GET /mangas/1 or /mangas/1.json
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
        format.html { redirect_to @manga, notice: "Manga was successfully created." }
        format.json { render :show, status: :created, location: @manga }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @manga.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @manga.update(manga_params)
        format.html { redirect_to @manga, notice: "Manga was successfully updated." }
        format.json { render :show, status: :ok, location: @manga }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @manga.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @manga.destroy!

    respond_to do |format|
      format.html { redirect_to mangas_path, status: :see_other, notice: "Manga was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def manga_params
    params.require(:manga).permit(:title, :alternative_title, :status, :manga_type, 
                                  :series, :author, :rating, :created_date, 
                                  :genre, :image_cover, :synopsis)
  end

  def set_manga
    @manga = if params[:id].to_i.to_s == params[:id]
               Manga.find(params[:id])
             else
               Manga.find_by!(title: params[:id].tr('-', ' '))
             end
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this area."
      redirect_to root_path
    end
  end
end
