FactoryBot.define do
  factory :paragraph do
    story { Story.new }
    author { User.first || FactoryBot.create(:user) }
    position { 1 }
    content { Faker::Lorem.paragraph_by_chars(number: 200) }
  end
end
