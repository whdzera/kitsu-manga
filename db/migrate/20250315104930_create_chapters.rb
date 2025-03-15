class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters do |t|
      t.references :manga, null: false, foreign_key: true
      t.integer :chapter_number
      t.text :images

      t.timestamps
    end
  end
end
