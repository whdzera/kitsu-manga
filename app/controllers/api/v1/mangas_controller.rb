module Api
  module V1
    class MangasController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]
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
        @manga.destroy
        head :no_content
      end

      private

      def set_manga
        @manga =
          Manga.find_by(id: params[:id]) ||
            Manga.find_by(title: params[:id].tr("-", " "))
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
