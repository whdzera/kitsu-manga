class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_manga_and_chapter

  def create
    @comment = @chapter.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html do
          redirect_to manga_chapter_path(@manga.title, @chapter.chapter_number),
                      notice: "Comment posted successfully."
        end
      else
        format.turbo_stream do
          render turbo_stream:
                   turbo_stream.replace(
                     "comment_form",
                     partial: "comments/form",
                     locals: {
                       manga: @manga,
                       chapter: @chapter,
                       comment: @comment
                     }
                   )
        end
        format.html do
          redirect_to manga_chapter_path(@manga.title, @chapter.chapter_number),
                      notice: "Failed to post comment."
        end
      end
    end
  end

  def destroy
    @comment = @chapter.comments.find(params[:id])
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
        format.html do
          redirect_to manga_chapter_path(@manga.title, @chapter.chapter_number),
                      notice: "Comment deleted."
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream:
                   turbo_stream.replace(
                     "flash",
                     partial: "shared/flash",
                     locals: {
                       notice: "You can't delete someone else's comment."
                     }
                   )
        end
        format.html do
          redirect_to manga_chapter_path(@manga.title, @chapter.chapter_number),
                      notice: "You can't delete someone else's comment."
        end
      end
    end
  end

  private

  def set_manga_and_chapter
    @manga = Manga.find(params[:manga_id])
    @chapter = @manga.chapters.find_by!(chapter_number: params[:chapter_number])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
