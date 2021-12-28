class Story < ApplicationRecord
  include Scorable

  has_many :paragraphs

  ADDRESS_SEPARATOR = "."

  def self.start(content:, author:)
    story = create
    story.paragraphs.create(content: content, author: author, address: "0")
    story
  end

  def first_paragraph
    paragraphs.first
  end

  def paragraph_at(address)
    return first_paragraph if address == "0"
    paragraph_ids = address.split(ADDRESS_SEPARATOR)
    current_paragraph = first_paragraph
    paragraph_ids.each do |paragraph_id|
      current_paragraph = current_paragraph.next_paragraphs.find(paragraph_id)
    end
    current_paragraph
  end

  def progress
    decimal = paragraphs.maximum("level").to_f / Paragraph::MAX_LEVEL
    (decimal * 100).round
  end

  def last_updated_date
    paragraphs.maximum("updated_at").strftime('%F')
  end

  def title
    first_paragraph.to_s.split(" ").slice(0..4).join(" ") + " …"
  end

  private

  def calculated_score
    @score ||= paragraphs.sum("score")
  end
end
