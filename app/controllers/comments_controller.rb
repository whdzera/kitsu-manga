class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chapter

  def create
    @comment = @chapter.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to redirect_to manga_chapter_path(
                                @manga.id,
                                @chapter.chapter_number
                              ),
                              notice: "Comment has been added successfully!"
    else
      redirect_to redirect_to manga_chapter_path(
                                @manga.id,
                                @chapter.chapter_number
                              ),
                              alert: "Comment could not be added."
    end
  end

  private

  def set_chapter
    @manga = Manga.find(params[:manga_id])

    redirect_to mangas_path, alert: "Manga not found" and return unless @manga

    @chapter = @manga.chapters.find_by(chapter_number: params[:chapter_number])

    redirect_to manga_path(@manga), alert: "Chapter not found" unless @chapter
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
