class Relationship < ApplicationRecord
  belongs_to :user_follows, class_name: "User"
  belongs_to :user_followed, class_name: "User"
end
