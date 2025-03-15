class MangasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # Guest bisa lihat index & show
  before_action :require_admin, only: [:create, :new, :update, :edit, :destroy]
  before_action :set_manga, only: [:show, :edit, :update, :destroy]

  def to_param
    title.parameterize  # Mengubah title jadi slug (misalnya: "Blue Lock" -> "blue-lock")
  end

  # GET /mangas or /mangas.json
  def index
    @mangas = Manga.all
  end

  # GET /mangas/1 or /mangas/1.json
  def show
    @chapters = @manga.chapters.order(:chapter_number)
  end

  # GET /mangas/new (Hanya Admin)
  def new
    @manga = Manga.new
  end

  # GET /mangas/1/edit (Hanya Admin)
  def edit
  end

  # POST /mangas or /mangas.json (Hanya Admin)
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

  # PATCH/PUT /mangas/1 or /mangas/1.json (Hanya Admin)
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

  # DELETE /mangas/1 or /mangas/1.json (Hanya Admin)
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
                                  :genre, :chapter, :image_cover, :image)
  end

  def set_manga
    @manga = Manga.find_by!(title: params[:id].tr('-', ' ')) 
    redirect_to mangas_path, alert: "Manga not found" if @manga.nil?
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this area."
      redirect_to root_path
    end
  end
end
