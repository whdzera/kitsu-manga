module Api
  module V1
    class ChaptersController < Api::BaseController
      before_action :authenticate_user!, except: %i[index show]
      before_action :require_admin, only: %i[create update destroy]
      before_action :set_manga
      before_action :set_chapter, only: %i[show update destroy]

      def index
        @chapters = @manga.chapters
        render json: @chapters
      end

      def show
        @chapter =
          @manga.chapters.find_by(chapter_number: params[:chapter_number])

        if @chapter
          render json: @chapter
        else
          render json: { error: "Chapter not found" }, status: :not_found
        end
      end

      def create
        @chapter = @manga.chapters.new(chapter_params)
        if @chapter.save
          render json: @chapter, status: :created
        else
          render json: {
                   errors: @chapter.errors.full_messages
                 },
                 status: :unprocessable_entity
        end
      end

      def update
        if @chapter.update(chapter_params)
          render json: @chapter
        else
          render json: {
                   errors: @chapter.errors.full_messages
                 },
                 status: :unprocessable_entity
        end
      end

      def destroy
        if @chapter.destroy
          render json: {
                   message: "Chapter deleted successfully",
                   id: @chapter.id
                 },
                 status: :ok
        else
          render json: {
                   error: "Failed to delete chapter"
                 },
                 status: :unprocessable_entity
        end
      end

      private

      def set_manga
        return if @manga.present?

        title_param = params[:manga_id]
        if title_param.blank?
          render json: {
                   error: "Missing manga identifier"
                 },
                 status: :bad_request
          return
        end

        normalized_title = title_param.tr("-", " ")
        @manga =
          Manga.where(
            "LOWER(title) LIKE ?",
            "%#{normalized_title.downcase}%"
          ).first

        unless @manga
          render json: { error: "Manga not found" }, status: :not_found
        end
      end

      def set_chapter
        @chapter =
          @manga.chapters.find_by(chapter_number: params[:chapter_number])
        unless @chapter
          render json: { error: "Chapter not found" }, status: :not_found
        end
      end

      def chapter_params
        params.require(:chapter).permit(:chapter_number, :images)
      end
    end
  end
end
