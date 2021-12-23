class Story < ApplicationRecord
  has_many :paragraphs

  def paragraphs_at(position)
    paragraphs.where(position: position).order("score DESC")
  end
end
