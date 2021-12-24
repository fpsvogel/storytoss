FactoryBot.define do
  factory :dislike do
    user { create(:user) }
    paragraph { create(:paragraph, author: user) }
  end
end
