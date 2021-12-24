FactoryBot.define do
  factory :paragraph do
    transient do
      likes_count { 0 }
      dislikes_count { 0 }
    end

    story { Story.new }
    author { User.first || FactoryBot.create(:user) }
    content { Faker::Lorem.paragraph_by_chars(number: 200) }
    likes do
      Array.new(likes_count) do |i|
        association(:like, user: author)
      end
    end
    dislikes do
      Array.new(dislikes_count) do |i|
        association(:dislike, user: author)
      end
    end
  end
end
