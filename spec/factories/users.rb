FactoryBot.define do
  factory :user do
    username { "user123" }
    email { "user@example.jp" }
    password { "qwerty" }
    password_confirmation { password || "qwerty" }
  end
end
