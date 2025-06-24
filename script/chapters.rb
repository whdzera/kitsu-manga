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

seed_chapters("Kimi ni Todoke", 30)
seed_chapters("Kingdom", 30)
seed_chapters("Kubo Won't Let Me Be Invisible", 30)
seed_chapters("Lovely Complex", 30)
seed_chapters("Magi The Labyrinth of Magic", 30)
seed_chapters("Maison Ikkoku", 30)
seed_chapters("March Comes in Like a Lion", 30)
seed_chapters("Monster", 30)
seed_chapters("My Hero Academia", 30)
seed_chapters("My Youth Romantic Comedy Is Wrong as I Expected", 30)
seed_chapters("Nana", 30)
seed_chapters("Naruto", 30)
seed_chapters("Nausicaä of the Valley of the Wind", 30)
seed_chapters("Nodame Cantabile", 30)
seed_chapters("Noragami", 30)
seed_chapters("Orange", 30)
seed_chapters("One Punch Man", 30)
seed_chapters("Ouran High School Host Club", 30)
seed_chapters("Oyasumi Punpun", 30)
seed_chapters("Pandora Hearts", 30)
seed_chapters("Parasyte", 30)
seed_chapters("Planetes", 30)
seed_chapters("Pluto", 30)
seed_chapters("Revolutionary Girl Utena", 30)
seed_chapters("Rurouni Kenshin", 30)
seed_chapters("Sailor Moon", 30)
seed_chapters("Shaman King", 30)
seed_chapters("Silver Spoon", 30)
seed_chapters("Skip Beat", 30)
seed_chapters("Slam Dunk", 30)
seed_chapters("Soul Eater", 30)
seed_chapters("Spy x Family", 30)
seed_chapters("The Promised Neverland", 30)
seed_chapters("The Seven Deadly Sins", 30)
seed_chapters("To Your Eternity", 30)
seed_chapters("Tokyo Ghoul", 30)
seed_chapters("Tokyo Revengers", 30)
seed_chapters("Trigun", 30)
seed_chapters("Tsubasa Reservoir Chronicle", 30)
seed_chapters("Vagabond", 30)
seed_chapters("Vinland Saga", 30)
seed_chapters("Yona of the Dawn", 30)
seed_chapters("Yotsuba", 30)
seed_chapters("Yu Yu Hakusho", 30)
seed_chapters("Zatch Bell", 30)
