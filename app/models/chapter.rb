class Chapter < ApplicationRecord
  belongs_to :manga
  validates :chapter_number, presence: true
  validates :images, presence: true
end
