one_piece = Manga.find_by(title: "One Piece")

(1..1129).each do |n|
  Chapter.create!(
    manga_id: one_piece.id,
    chapter_number: n,
    images: "https://files.catbox.moe/qr9dw2.png"
  )
end

# version 2.0

def seed_chapters(title, chapter_count)
  manga = Manga.find_by(title: title)

  (1..chapter_count).each do |n|
    Chapter.create!(
      manga_id: manga.id,
      chapter_number: n,
      images: "https://files.catbox.moe/qr9dw2.png"
    )
  end
end

seed_chapters("One Piece", 1129)
