class Story < ApplicationRecord
  has_many :paragraphs

  def paragraphs_at(position)
    paragraphs.where(position: position).to_a.sort_by(&:score).reverse
  end
end
