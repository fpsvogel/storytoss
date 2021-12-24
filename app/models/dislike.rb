class Dislike < ApplicationRecord
  belongs_to :paragraph, counter_cache: true
  belongs_to :user
end
