FactoryBot.define do
  factory :wine_article do
    wine_name { 'DEAR RICH CHARDONNAY 2020' }
    wine_name_kana { 'ディアリッチ シャルドネ 2020' }
    wine_type_id { 3 }
    wine_taste_id { 3 }
    wine_price { 3278 }
    wine_shop { 'ヴィノスやまざき 西武渋谷店' }
    title { '美味しい白ワイン' }
    comment { '復刻したばかりとの事でヴィンテージは、若いですが、とても骨格がしっかりしていて飲みごたえがあります。トロピカルな華やかさも持っていて、私は好きです。' }
    association :user

    after(:build) do |wine_article|
      wine_article.image.attach(io: File.open('public/images/test_wine.jpeg'), filename: 'test_wine.jpeg')
    end
  end
end
