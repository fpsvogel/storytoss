FactoryBot.define do
  factory :like do
    user { create(:user) }
    paragraph { create(:paragraph, author: user) }
  end
end
