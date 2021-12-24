class Paragraph < ApplicationRecord
  belongs_to :story, optional: true
  belongs_to :author,
             class_name: "User",
             foreign_key: "user_id"
  belongs_to :previous,
             class_name: "Paragraph",
             optional: true
  alias_attribute :previous_paragraph, :previous
  has_many :continuations,
           class_name: "Paragraph",
           foreign_key: "previous_id"
  has_many :reactions

  MAX_LENGTH = 280
  MAX_LEVEL = 10

  validates :content,
            presence: true,
            length: { maximum: MAX_LENGTH }

  validate :validate_level_under_maximum

  def score
    likes = reactions.where(like: true).count
    dislikes = reactions.where(like: false).count
    likes - dislikes
  end

  def continuations_sorted
    continuations.to_a.sort_by(&:score).reverse
  end

  def continue(paragraph = nil, content: nil, author: nil)
    if paragraph
      continuations << paragraph
      continuation = paragraph
    else
      raise ArgumentError if content.nil? || author.nil?
      continuation = continuations.create(content: content, author: author)
    end
    continuation
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
