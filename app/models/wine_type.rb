class WineType < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '赤ワイン' },
    { id: 3, name: '白ワイン' },
    { id: 4, name: 'スパークリングワイン' },
    { id: 5, name: 'シャンパーニュ' },
    { id: 6, name: 'デザートワイン' },
    { id: 7, name: '酒精強化ワイン' },
    { id: 8, name: 'その他のカテゴリーのワイン' }
  ]

  include ActiveHash::Associations
  has_many :wine_articles
end
