require 'rails_helper'

RSpec.describe Story, type: :model do
  describe ".start" do
    let!(:content) { Faker::Lorem.paragraph_by_chars(number: 200) }
    let!(:author) { create(:user) }

    it "creates a new story with a first paragraph" do
      story = Story.start(content: content, author: author)
      expect(story.first_paragraph.content).to eq content
      expect(story.first_paragraph.author).to eq author
    end
  end

  describe "#paragraph_at" do
    let!(:last_level) { 6 }
    let!(:last_contents) { ["And then there were none.", "And then there were still a few."] }
    let!(:story) do
      the_story = create(:story, random_paragraphs_count: last_level - 1)
      paragraph = the_story.first_paragraph
      (last_level - 2).times do
        paragraph = paragraph.next_paragraphs.first
      end
      paragraph.next_paragraphs << create(:paragraph, content: last_contents.first)
      last_paragraph = create(:paragraph, content: last_contents.second)
      paragraph.next_paragraphs << last_paragraph
      @last_id = last_paragraph.id
      the_story
    end
    let!(:first_paragraph_id) { story.first_paragraph.id }
    let!(:last_paragraph_id) { @last_id }
    let!(:last_branch_id) do
      random_branch_id = ((first_paragraph_id + 1)..(first_paragraph_id + last_level - 2))
                            .map(&:to_s)
                            .join(Story::BRANCH_ID_SEPARATOR)
      random_branch_id + "#{Story::BRANCH_ID_SEPARATOR}#{last_paragraph_id}"
    end

    it "returns the correct paragraph" do
      last_paragraph = story.paragraph_at(last_branch_id)
      expect(last_paragraph.content).to eq last_contents.second
    end
  end

  describe "#score" do
    let!(:story) do
      the_story = create(:story)
      the_story.first_paragraph
               .add_next(create(:paragraph, likes_count: 12, dislikes_count: 1))
      the_story.first_paragraph
               .add_next(create(:paragraph, likes_count: 25, dislikes_count: 5))
      the_story
    end

    it "returns the sum of all paragraph scores" do
      expect(story.score).to eq 31
    end
  end

  describe "#progress" do
    let!(:story) { create(:story, random_paragraphs_count: Paragraph::MAX_LEVEL / 2) }

    it "returns the percentage toward story completion" do
      expect(story.progress).to eq 50
    end
  end
end
