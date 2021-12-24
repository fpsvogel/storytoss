FactoryBot.define do
  factory :story do
    transient do
      random_paragraphs_count { 0 }
    end

    first_paragraph do
      if random_paragraphs_count > 0
        first = create(:paragraph)
        remaining_random = random_paragraphs_count - 1
      end
      current = first
      (remaining_random).times do
        continuation = create(:paragraph)
        current.continuations << continuation
        current = continuation
      end
      first
    end
  end
end
