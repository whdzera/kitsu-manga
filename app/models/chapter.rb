class Chapter < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :manga
  validates :chapter_number, presence: true
  validates :images, presence: true
end
