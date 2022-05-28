# テーブル設計

## usersテーブル

| Column             | Type    | Options
|--------------------|---------|---------------------------|
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birthday           | date    | null: false               |

## Association
has_many :wine_articles
has_many :comments
has_many :favorites
has_many :favorite_wine_articles, through: :favorites, source: :wine_article
has_many :relationships, class_name: "Relationship", foreign_key: :follows_user_id, dependent: :destroy
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :followed_user_id, dependent: :destroy
has_many :follows_me, through: :relationships, source: :followed_user_id
has_many :followed_by_me, through: :relationships, source: :follows_user_id

## wine_articlesテーブル

| Column             | Type       | Options
|--------------------|------------|--------------------------------|
| wine_name          | string     | null: false                    |
| wine_name_kana     | string     |                                |
| wine_price         | integer    | null: false                    |
| wine_shop          | string     | null: false                    |
| title              | string     | null: false                    |
| comment            | text       | null: false                    |
| wine_type_id       | integer    | null: false                    |
| wine_taste_id      | integer    | null: false                    |
| user_id            | references | null: false, foreign_key: true |

## Association
belongs_to :user
has_many :comments
extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to :wine_type
extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to :wine_taste
has_many :favorites

## Commentsテーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| text               | text       | null: false                    |
| user_id            | references | null: false, foreign_key: true |
| wine_article_id    | references | null: false, foreign_key: true |

## Association
belongs_to :user
belongs_to :wine_article

## Favoritesテーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| user_id            | references | null: false, foreign_key: true |
| wine_article_id    | references | null: false, foreign_key: true |

## Association
belongs_to :user
belongs_to :wine_article

## Relationshipsテーブル

| Column                  | Type       | Options        |
|-------------------------|------------|----------------|
| follows_user_id         | integer    | null: false    |
| followed_user_id        | integer    | null: false    |

## Association
belongs_to :follows_user_id, class_name: "User"
belongs_to :followed_user_id, class_name: "User"