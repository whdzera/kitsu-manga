class ChaptersController < ApplicationController
  before_action :authenticate_user!, except: [:show] # Guest bisa lihat index & show
  before_action :require_admin, only: [:create, :new, :update, :edit, :destroy]
  before_action :set_manga
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @chapter = @manga.chapters.build

    latest_chapter = @manga.chapters.maximum(:chapter_number) || 0
    @chapter.chapter_number = latest_chapter + 1
  end

  def create
    @chapter = @manga.chapters.build(chapter_params)

    if @chapter.save
      redirect_to manga_chapter_path(@manga.title, @chapter.chapter_number),
                  notice: "Chapter #{@chapter.chapter_number} added successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @chapter.update(chapter_params)
      redirect_to manga_chapter_path(@manga.title, @chapter.chapter_number),
                  notice: "Chapter #{@chapter.chapter_number} updated successfully!"
    else
      flash[:alert] = "Failed to update chapter: #{@chapter.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    chapter_number = @chapter.chapter_number
    
    if @chapter.destroy
      redirect_to manga_path(@manga.title), 
                  notice: "Chapter #{chapter_number} Delete Succesfully!"
    else
      redirect_to manga_chapter_path(@manga.title, @chapter.chapter_number),
                  alert: "Failed to chapter chapter: #{@chapter.errors.full_messages.join(', ')}"
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:chapter_number, :images)
  end

  def set_manga
    @manga = Manga.find_by(title: params[:manga_id].tr("-", " "))
    redirect_to mangas_path, alert: "Manga not found" unless @manga
  end

  def set_chapter
    @chapter = @manga.chapters.find_by(chapter_number: params[:chapter_number])
    redirect_to manga_path(@manga), alert: "Chapter not found" unless @chapter
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this area."
      redirect_to root_path
    end
  end
  
end
