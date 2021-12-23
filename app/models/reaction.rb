class Reaction < ApplicationRecord
  belongs_to :paragraph
  belongs_to :user
end
