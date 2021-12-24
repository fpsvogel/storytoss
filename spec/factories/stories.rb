FactoryBot.define do
  factory :story do
    transient do
      random_paragraphs_count { 1 }
    end

    first_paragraph do
      first = create(:paragraph)
      remaining_random = random_paragraphs_count - 1
      current = first
      remaining_random.times do
        current = current.add_next(create(:paragraph))
      end
      first
    end
  end
end
