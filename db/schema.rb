ActiveRecord::Schema[8.0].define(version: 2025_03_15_084039) do
  create_table "mangas", force: :cascade do |t|
    t.string "title"
    t.string "alternative_title"
    t.string "image_cover"
    t.string "status"
    t.string "manga_type"
    t.string "series"
    t.string "author"
    t.float "rating"
    t.date "created_date"
    t.string "genre"
    t.integer "chapter"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "member"
    t.string "username"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end
end
