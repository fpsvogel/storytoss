FactoryBot.define do
  factory :user do
    username { Faker::Alphanumeric.unique.alphanumeric(number: 10) }
    email { Faker::Internet.unique.email }
    password { "qwerty" }
    password_confirmation { password || "qwerty" }
  end
end
