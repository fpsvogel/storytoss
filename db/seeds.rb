# TODO: prevent the same user from continuing a story twice

USERS_TO_CREATE = 5
STORIES_TO_CREATE = 3
STORY_COMPLETE_PROBABILITY = 0.75
ALTERNATIVE_PARAGRAPH_PROBABILITY = 0.3
ALTERNATIVE_ADD_PROBABILITY = 0.5
MAX_REACTIONS_PER_PARAGRAPH = 20

Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each do |file|
  require file
end
