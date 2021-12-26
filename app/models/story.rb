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
      current_paragraph = current_paragraph.next_paragraphs.find(paragraph_id)
    end
    current_paragraph
  end

  def score
    calculated_score
  end

  def score_formatted
    sprintf("%+d", score)
  end

  def score_in_a_word
    if calculated_score > 0
      "positive"
    elsif calculated_score == 0
      "zero"
    else
      "negative"
    end
  end

  def progress
    decimal = paragraphs.maximum("level").to_f / Paragraph::MAX_LEVEL
    (decimal * 100).round
  end

  private

  def calculated_score
    @score ||= paragraphs.sum("score")
  end
end
