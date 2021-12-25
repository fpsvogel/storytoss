# Like and Dislike are identical. the alternative to this duplication is to combine them both into a Reaction model, which has a "like" boolean column to distinguish likes from dislikes. that would require a bit more querying to get just likes or just dislikes, so for now I went with this duplicating approach. in the future if more reactions are added, or if more functionality is added into them, it might be better to combine them into Reaction to prevent the duplication from growing too much.

class Like < ApplicationRecord
  belongs_to :paragraph
  belongs_to :user

  after_save :update_counter_cache
  after_destroy :update_counter_cache

  private

  def update_counter_cache
    paragraph.update_attribute(:score, paragraph.likes.count - paragraph.dislikes.count)
  end
end
