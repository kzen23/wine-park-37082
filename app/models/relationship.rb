class Relationship < ApplicationRecord
  belongs_to :follows_user_id, class_name: "User"
  belongs_to :followed_user_id, class_name: "User"
end
