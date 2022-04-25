FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 6) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name             { '白ブドウ' }
    first_name            { '泡え' }
    last_name_kana        { 'シロブドウ' }
    first_name_kana       { 'アワエ' }
    birthday              { '1975-06-21' }
  end
end
