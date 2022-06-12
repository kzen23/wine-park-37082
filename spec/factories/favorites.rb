FactoryBot.define do
  factory :favorite do
    association :user
    association :wine_article
  end
end
