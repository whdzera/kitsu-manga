class RemoveChapterAndImageFromMangas < ActiveRecord::Migration[8.0]
  def change
    remove_column :mangas, :chapter, :integer
    remove_column :mangas, :image, :string
  end
end
