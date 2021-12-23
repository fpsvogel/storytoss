FactoryBot.define do
  factory :paragraph do
    story { Story.new }
    author { FactoryBot.create(:user) }
    position { 1 }
    content { "Once upon a time, in a land far, far away…" }
  end
end
