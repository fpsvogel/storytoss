class Reaction < ApplicationRecord
  belongs_to :paragraph
  belongs_to :user

  after_save :update_counter_cache
  after_destroy :update_counter_cache

  validates_uniqueness_of :user_id,
                          scope: :paragraph_id

  scope :like, -> { where(like: true) }
  scope :dislike, -> { where(like: false) }

  private

  def update_counter_cache
    likes_count = paragraph.likes.count
    dislikes_count = paragraph.dislikes.count
    paragraph.update(likes_count: likes_count,
                     dislikes_count: dislikes_count,
                     score: likes_count - dislikes_count)
  end
end
