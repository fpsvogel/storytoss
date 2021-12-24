FactoryBot.define do
  factory :paragraph do
    transient do
      likes { 0 }
      dislikes { 0 }
    end

    story { Story.new }
    author { User.first || FactoryBot.create(:user) }
    content { Faker::Lorem.paragraph_by_chars(number: 200) }
    reactions do
      like_reactions = Array.new(likes) do |i|
        association(:like_reaction, user: author)
      end
      dislike_reactions = Array.new(dislikes) do |i|
        association(:dislike_reaction, user: author)
      end
      like_reactions + dislike_reactions
    end
  end
end
