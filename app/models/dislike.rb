class Dislike < ApplicationRecord
  belongs_to :paragraph
  belongs_to :user

  after_save :update_counter_cache
  after_destroy :update_counter_cache

  private

  def update_counter_cache
    paragraph.update_attribute(:score, paragraph.likes.count - paragraph.dislikes.count)
  end
end
