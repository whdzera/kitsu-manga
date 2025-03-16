class AddSynopsisToMangas < ActiveRecord::Migration[8.0]
  def change
    add_column :mangas, :synopsis, :text
  end
end
