FactoryBot.define do
  factory :paragraph do
    transient do
      auto_likes { 0 }
      auto_dislikes { 0 }
    end

    story { Story.new }
    author { FactoryBot.create(:user) }
    content { Faker::Lorem.paragraph_by_chars(number: 200) }
    likes do
      Array.new(auto_likes) do |i|
        association(:reaction, like: true, user: FactoryBot.create(:user))
      end
    end
    dislikes do
      Array.new(auto_dislikes) do |i|
        association(:reaction, like: false, user: FactoryBot.create(:user))
      end
    end
  end
end
