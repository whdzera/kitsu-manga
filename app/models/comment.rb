class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :chapter

  validates :body, presence: true
end
