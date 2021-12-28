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
  has_many :reactions
  has_many :likes, -> { like }, class_name: "Reaction"
  has_many :dislikes, -> { dislike }, class_name: "Reaction"

  MAX_LENGTH = 280
  MAX_LEVEL = 10

  validates :content,
            presence: true,
            length: { maximum: MAX_LENGTH }

  validates :level,
            presence: true,
            numericality: { only_integer: true,
                            in: 1..MAX_LEVEL }

  validate :validate_level_under_maximum

  validates_uniqueness_of :user_id,
                          scope: :story_id,
                          message: "has already added a paragraph to this story"

  attribute :level, :integer, default: 1
  attribute :score, :integer, default: 0

  def next_paragraphs_sorted
    nexts.order('score DESC')
  end

  alias_method :nexts_sorted, :next_paragraphs_sorted

  def add_next_paragraph(paragraph = nil, content: nil, author: nil)
    if paragraph
      next_paragraphs << paragraph
      paragraph.update(story: story,
                       level: level + 1,
                       address: address_with(paragraph.id))
      added_paragraph = paragraph
    else
      raise ArgumentError if content.nil? || author.nil?
      added_paragraph = next_paragraphs.create(content: content,
                                               author: author,
                                               story: story,
                                               level: level + 1)
      added_paragraph.update(address: address_with(added_paragraph.id))
    end
    added_paragraph
  end

  alias_method :add_next, :add_next_paragraph

  def toggle_like(user:)
    toggle_reaction(:like, user)
  end

  def toggle_dislike(user:)
    toggle_reaction(:dislike, user)
  end

  def to_s
    content
  end

  def last_updated_date
    updated_at.strftime('%F')
  end

  # TODO: remove duplication here and in story.rb by moving the score methods into a mixin.

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

  def toggle_reaction(type, user)
    reactions.find_or_initialize_by(user: user, paragraph: self)
             .send("toggle_#{type}")
  end

  def calculated_score
    @score ||= read_attribute(:score)
  end

  def address_with(next_id)
    if address
      "#{address}#{Story::ADDRESS_SEPARATOR}#{next_id}"
    else
      next_id.to_s
    end
  end
end
