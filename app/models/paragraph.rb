class Paragraph < ApplicationRecord
  belongs_to :story
  belongs_to :author,
             class_name: "User",
             foreign_key: "user_id"
  belongs_to :previous,
             class_name: "Paragraph",
             optional: true
  has_many :continuations,
           class_name: "Paragraph",
           foreign_key: "previous_id"
  has_many :reactions

  MAX_LENGTH = 280

  validates :content,
            presence: true,
            length: { maximum: MAX_LENGTH }

  validates :score,
            presence: true,
            numericality: { only_integer: true }

  attribute :score, :integer, default: 0

  def score
    likes = reactions.where(like: true).count
    dislikes = reactions.where(like: false).count
    likes - dislikes
  end

  def continuations_sorted
    continuations.to_a.sort_by(&:score).reverse
  end
end
