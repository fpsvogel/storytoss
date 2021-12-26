progressbar = ProgressBar.create(
  title: 'Creating Stories',
  total: STORIES_TO_CREATE
)

def random_paragraph_content
  Faker::Hipster.paragraph_by_chars(characters: 200)
end

def random_user
  User.find(User.pluck(:id).sample)
end

def last_level
  if rand < STORY_COMPLETE_PROBABILITY
    Paragraph::MAX_LEVEL
  else
    (rand * Paragraph::MAX_LEVEL).ceil
  end
end

def branch(paragraph, current_level:)
  return false unless rand < ALTERNATIVE_PARAGRAPH_PROBABILITY
  branch_tip = paragraph
  (Paragraph::MAX_LEVEL - current_level).times do
    branch_tip = with_likes_and_dislikes(
                  branch_tip.add_next(content: random_paragraph_content,
                                      author: random_user))
    break unless rand < ALTERNATIVE_ADD_PROBABILITY
  end
  true
end

def add_next(paragraph)
  with_likes_and_dislikes(
    paragraph.add_next(content: random_paragraph_content, author: random_user))
end

def with_likes_and_dislikes(paragraph)
  (rand * 10).round.times do
    paragraph.likes.create(user: random_user)
  end
  (rand * 10).round.times do
    paragraph.dislikes.create(user: random_user)
  end
  paragraph
end

STORIES_TO_CREATE.times do
  story = Story.start(content: random_paragraph_content, author: random_user)
  last_paragraph = story.first_paragraph
  (last_level - 1).times do |i|
    loop { break unless branch(last_paragraph, current_level: i + 1) }
    last_paragraph = add_next(last_paragraph)
  end
  progressbar.increment
end