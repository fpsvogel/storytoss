FactoryBot.define do
  factory :story do
    transient do
      random_paragraphs_count { 1 }
    end

    after(:create) do |story, evaluator|
      break unless evaluator.random_paragraphs_count > 0
      first = create(:paragraph)
      story.update(first_paragraph: first)
      remaining_random = evaluator.random_paragraphs_count - 1
      current = first
      remaining_random.times do
        current = current.add_next(create(:paragraph))
      end
    end
  end
end
