class Relationship < ApplicationRecord
  belongs_to :user_follows_id, class_name: "User"
  belongs_to :user_followed_id, class_name: "User"
end
