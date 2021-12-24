class Story < ApplicationRecord
  has_one :first_paragraph, class_name: "Paragraph"
  has_many :paragraphs

  BRANCH_ID_SEPARATOR = "."

  def self.start(content:, author:)
    story = create
    story.create_first_paragraph(content: content, author: author)
    story
  end

  def paragraph_at(branch_id)
    paragraph_ids = branch_id.split(BRANCH_ID_SEPARATOR)
    current_paragraph = first_paragraph
    paragraph_ids.each do |paragraph_id|
      current_paragraph = current_paragraph.continuations.find(paragraph_id)
    end
    current_paragraph
  end

  def score
    paragraphs.sum(&:likes_count) - paragraphs.sum(&:dislikes_count)
  end
end
