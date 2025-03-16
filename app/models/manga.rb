class Manga < ApplicationRecord
  has_many :chapters, dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
  validates :alternative_title, length: { maximum: 255 }, allow_blank: true
  validates :image_cover, presence: true
  validates :status, inclusion: { in: %w[Ongoing Completed Hiatus Dropped] }
  validates :manga_type, presence: true
  validates :series, length: { maximum: 255 }, allow_blank: true
  validates :author, presence: true, length: { maximum: 255 }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :created_date, presence: true, comparison: { less_than_or_equal_to: Date.today }
  validates :genre, presence: true, format: { with: /\A[a-zA-Z\s,]+\z/, message: "only allows letters and commas" }
  validates :synopsis, presence: true
end
