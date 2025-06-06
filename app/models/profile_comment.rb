class ProfileComment < ApplicationRecord
  belongs_to :user
  belongs_to :profile_user, class_name: "User"

  validates :body, presence: true, length: { minimum: 5, maximum: 700 }
end
