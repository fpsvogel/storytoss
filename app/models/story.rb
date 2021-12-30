class Story < ApplicationRecord
  include Scorable

  ADDRESS_SEPARATOR = "."
  TITLE_LENGTH = 5

  has_many :paragraphs, dependent: :destroy

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
    words = first_paragraph.to_s.split(" ")
    "#{words.slice(0..TITLE_LENGTH - 1).join(" ")}#{" …" if words.count > TITLE_LENGTH}"
  end

  def score
    paragraphs.sum("score")
  end
end
