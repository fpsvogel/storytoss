class Paragraph < ApplicationRecord
  belongs_to :story
  belongs_to :author,
              class_name: "User",
              foreign_key: "user_id"
  belongs_to :previous_paragraph,
              class_name: "Paragraph",
              optional: true
  alias_attribute :previous, :previous_paragraph
  has_many :next_paragraphs,
            class_name: "Paragraph",
            foreign_key: "previous_paragraph_id"
  alias_attribute :nexts, :next_paragraphs
  has_many :likes
  has_many :dislikes

  MAX_LENGTH = 280
  MAX_LEVEL = 10

  validates :content,
            presence: true,
            length: { maximum: MAX_LENGTH }

  validate :validate_level_under_maximum

  def next_paragraphs_sorted
    nexts.order('score DESC')
  end

  alias_method :nexts_sorted, :next_paragraphs_sorted

  def add_next_paragraph(paragraph = nil, content: nil, author: nil)
    if paragraph
      next_paragraphs << paragraph
      paragraph.story = story
      paragraph.save
      added_paragraph = paragraph
    else
      raise ArgumentError if content.nil? || author.nil?
      added_paragraph = next_paragraphs.create(content: content,
                                               author: author,
                                               story: story)
    end
    added_paragraph
  end

  alias_method :add_next, :add_next_paragraph

  def to_s
    content
  end

  private

  def validate_level_under_maximum
    ancestor_paragraph = self
    levels = 1
    loop do
      break if ancestor_paragraph.previous.nil?
      levels += 1
      ancestor_paragraph = ancestor_paragraph.previous
    end
    if levels > MAX_LEVEL
      errors.add(:base, "exceeded the story length")
    end
  end
end
