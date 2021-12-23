class Paragraph < ApplicationRecord
  belongs_to :story
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :reactions

  MAX_POSITION = 10
  MAX_LENGTH = 280

  validates :position,
            presence: true,
            numericality: { in: 1..MAX_POSITION,
                            only_integer: true }

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
end
