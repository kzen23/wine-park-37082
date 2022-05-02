class WineTaste < ActiveHash::Base
  self.data = [
    { id: 1,  name: '--' },
    { id: 2,  name: '極辛口' },
    { id: 3,  name: '辛口' },
    { id: 4,  name: 'やや辛口' },
    { id: 5,  name: 'やや甘口' },
    { id: 6,  name: '甘口' },
    { id: 7,  name: '極甘口' },
    { id: 8,  name: 'ライトボディ' },
    { id: 9,  name: 'ミディアムボディ' },
    { id: 10, name: 'フルボディ' }
  ]

  include ActiveHash::Associations
  has_many :wine_articles
  
end