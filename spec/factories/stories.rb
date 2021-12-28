FactoryBot.define do
  factory :story do
    transient do
      random_paragraphs_count { 1 }
    end

    after(:create) do |story, evaluator|
      break unless evaluator.random_paragraphs_count > 0
      story.paragraphs.create(content: Faker::Lorem.paragraph_by_chars(number: 200),
                              author: FactoryBot.create(:user),
                              address: "0")
      remaining_random = evaluator.random_paragraphs_count - 1
      current = story.first_paragraph
      remaining_random.times do
        current = current.add_next(create(:paragraph))
      end
    end
  end
end
