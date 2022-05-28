class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'is invalid. Include both letters and numbers' }

  with_options presence: true do
    validates :nickname, length: { maximum: 20 }
    validates :birthday

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

  has_many :wine_articles
  has_many :comments

  # フォローする、されたの関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "user_follows_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "user_followed_id", dependent: :destroy
  # 実装で使うための記述、フォローされてる側
  has_many :followed, through: :relationships, source: :user_followed
  # フォローしてる側
  has_many :follows, through: :reverse_of_relationships, class_name: "Relationship", source: :user_follows

  def follow(user_id)
    relationships.create(user_followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(user_followed_id: user_id).destroy
  end

  def followed?(user)
    followed.include?(user)
  end
end
