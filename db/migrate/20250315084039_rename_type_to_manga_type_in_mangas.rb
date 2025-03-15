class RenameTypeToMangaTypeInMangas < ActiveRecord::Migration[8.0]
  def change
    rename_column :mangas, :type, :manga_type
  end
end
