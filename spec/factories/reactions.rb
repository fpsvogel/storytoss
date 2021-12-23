FactoryBot.define do
  factory :reaction do
    factory :like_reaction do
      user { create(:user) }
      paragraph { create(:paragraph, author: user) }
      like { true }
    end

    factory :dislike_reaction do
      user { create(:user) }
      paragraph { create(:paragraph, author: user) }
      like { false }
    end
  end
end
