class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wine_article

  validates :text, presence: true, length: { maximum: 100 }
end
