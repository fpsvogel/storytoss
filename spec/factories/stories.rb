FactoryBot.define do
  factory :story do
    transient do
      random_paragraphs_count { 0 }
      manual_contents { [] }
      manual_likes { [] }
      manual_positions { [] }
    end

    paragraphs do
      random = Array.new(random_paragraphs_count) do |i|
        association(:paragraph, position: i + 1)
      end
      manual = manual_contents.map.with_index do |content, i|
        association(:paragraph, content: content,
                                position: manual_positions[i] || random.count + 1 + i,
                                likes: manual_likes[i] || 0)
      end
      random + manual
    end
  end
end
