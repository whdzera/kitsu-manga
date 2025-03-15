class MangasController < ApplicationController
  before_action :set_manga, only: %i[ show edit update destroy ]

  # GET /mangas or /mangas.json
  def index
    @mangas = Manga.all
  end

  # GET /mangas/1 or /mangas/1.json
  def show
  end

  # GET /mangas/new
  def new
    @manga = Manga.new
  end

  # GET /mangas/1/edit
  def edit
  end

  # POST /mangas or /mangas.json
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

  # PATCH/PUT /mangas/1 or /mangas/1.json
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

  # DELETE /mangas/1 or /mangas/1.json
  def destroy
    @manga.destroy!

    respond_to do |format|
      format.html { redirect_to mangas_path, status: :see_other, notice: "Manga was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    def manga_params
      params.require(:manga).permit(
        :title, :alternative_title, :image_cover, :status,
        :series, :author, :rating, :created_date, 
        :genre, :chapter, :image
      )
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_manga
      @manga = Manga.find(params[:id])  # There's also a typo here: .expect should be :id
    end

    # Only allow a list of trusted parameters through.
    def manga_params
      params.fetch(:manga, {})
    end
end
