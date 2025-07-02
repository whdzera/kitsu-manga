module Api
  module V1
    class Api::V1::MangasController < Api::BaseController
      before_action :authenticate_user!, except: %i[index show]
      before_action :require_admin, only: %i[create update destroy]
      before_action :set_manga, only: %i[show update destroy]

      def index
        @mangas = Manga.all
        render json: @mangas
      end

      def show
        render json: @manga
      end

      def create
        @manga = Manga.new(manga_params)
        if @manga.save
          render json: @manga, status: :created
        else
          render json: {
                   errors: @manga.errors.full_messages
                 },
                 status: :unprocessable_entity
        end
      end

      def update
        if @manga.update(manga_params)
          render json: @manga
        else
          render json: {
                   errors: @manga.errors.full_messages
                 },
                 status: :unprocessable_entity
        end
      end

      def destroy
        if @manga.destroy
          render json: {
                   message: "Manga deleted successfully",
                   id: @manga.id,
                   title: @manga.title
                 },
                 status: :ok
        else
          render json: {
                   error: "Failed to delete manga"
                 },
                 status: :unprocessable_entity
        end
      end

      private

      def set_manga
        @manga =
          Manga.find_by(id: params[:id]) ||
            Manga.where("title LIKE ?", "%#{params[:id].tr("-", " ")}%").first
        unless @manga
          render json: { error: "Manga not found" }, status: :not_found
        end
      end

      def manga_params
        params.require(:manga).permit(
          :title,
          :alternative_title,
          :image_cover,
          :status,
          :manga_type,
          :series,
          :author,
          :rating,
          :created_date,
          :genre,
          :synopsis
        )
      end
    end
  end
end
