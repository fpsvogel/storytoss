FactoryBot.define do
  factory :reaction do
    user { create(:user) }
    paragraph { create(:paragraph, author: user) }
  end
end
