class CreateMangas < ActiveRecord::Migration[8.0]
  def change
    create_table :mangas do |t|
      t.string :title
      t.string :alternative_title
      t.string :image_cover
      t.string :status
      t.string :type
      t.string :series
      t.string :author
      t.float :rating
      t.date :created_date
      t.string :genre
      t.integer :chapter
      t.string :image

      t.timestamps
    end
  end
end
