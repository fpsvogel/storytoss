# TODO: prevent the same user from continuing a story twice
# TODO: seed reactions

USERS_TO_CREATE = 3
STORIES_TO_CREATE = 2
STORY_COMPLETE_PROBABILITY = 0.75
ALTERNATIVE_PARAGRAPH_PROBABILITY = 0.3
ALTERNATIVE_ADD_PROBABILITY = 0.5

Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each do |file|
  require file
end
