progressbar = ProgressBar.create(
  title: 'Creating Static Stories',
  total: STORIES.count
)

def random_user
  User.find(User.pluck(:id).sample)
end

def add_next(paragraph, score)
  added = nil
  loop do
    added = paragraph.add_next(content: random_paragraph_content,
                               author: random_user)
    break if added.valid? # invalid if random_user already added a paragraph.
  end
  with_likes_and_dislikes(added, score)
end

def add_likes_and_dislikes(paragraph, score)
  until paragraph.score == score
    if score > 0
      paragraph.toggle_like(user: random_user)
    elsif score < 0
      paragraph.toggle_dislike(user: random_user)
    end
  end
end

def add_next_paragraphs(paragraph, key, story_index)
  counter = 1
  loop do
    next_key = :"#{key}.#{counter}"
    break unless STORIES[story_index].has_key?(next_key)
    next_content = STORIES[story_index][next_key].first
    next_score = STORIES[story_index][next_key].second || 0
    next_par = nil
    loop do
      next_par = paragraph.add_next(content: next_content,
                                 author: random_user)
      break if next_par.valid? # invalid if random_user already added a paragraph.
    end
    add_likes_and_dislikes(next_par, next_score)
    add_next_paragraphs(next_par, next_key, story_index)
    counter += 1
  end
end

(0..STORIES.count - 1).each do |story_index|
  story = Story.start(content: STORIES[story_index][:"0"].first, author: random_user)
  add_next_paragraphs(story.first_paragraph, "", story_index)
  progressbar.increment
end