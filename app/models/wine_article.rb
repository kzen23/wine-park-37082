class WineArticle < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_many   :comments
  belongs_to :wine_type
  belongs_to :wine_taste

  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :wine_name, length: { maximum: 40 }
    validates :wine_type_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :wine_taste_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :wine_price
    validates :wine_shop, length: { maximum: 40 }
    validates :title, length: { maximum: 40 }
    validates :comment, length: { maximum: 200 }
  end

  with_options numericality: { only_integer: true, message: 'is invalid. Input half width characters' } do
    validates :wine_price
    validates :wine_type_id
    validates :wine_taste_id
  end
end
