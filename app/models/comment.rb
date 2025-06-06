class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :chapter

  validates :body, presence: true, length: { minimum: 10, maximum: 700 }

  private
end
