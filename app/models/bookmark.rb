class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :manga
  validates :user_id, uniqueness: { scope: :manga_id, message: "already bookmarked" }
end
