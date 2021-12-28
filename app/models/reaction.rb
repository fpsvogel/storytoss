class Reaction < ApplicationRecord
  belongs_to :paragraph
  belongs_to :user

  after_save :update_counter_cache
  after_destroy :update_counter_cache

  validates_uniqueness_of :user_id,
                          scope: :paragraph_id,
                          message: "has already added a reaction to this paragraph"

  scope :like, -> { where(like: true) }
  scope :dislike, -> { where(like: false) }

  LIKE = :like
  DISLIKE = :dislike

  def toggle_like
    toggle_to(true)
  end

  def toggle_dislike
    toggle_to(false)
  end

  def to_sym
    like? ? LIKE : DISLIKE
  end

  private

  def update_counter_cache
    likes_count = paragraph.likes.count
    dislikes_count = paragraph.dislikes.count
    paragraph.update(likes_count: likes_count,
                     dislikes_count: dislikes_count,
                     score: likes_count - dislikes_count)
  end

  def toggle_to(like_boolean)
    if new_record? || like != like_boolean
      update(like: like_boolean)
      true
    else # if like is already set to like_boolean, remove the reaction.
      destroy
      nil
    end
  end
end
