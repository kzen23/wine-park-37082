FactoryBot.define do
  factory :comment do
    text { 'とても美味しそうですね♪' }
    association :user
    association :wine_article
  end
end
