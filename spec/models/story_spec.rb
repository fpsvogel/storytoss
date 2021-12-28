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

  describe "paragraph address" do
    let!(:last_level) { 6 }
    let!(:story) { create(:story, random_paragraphs_count: last_level - 1) }
    let!(:last_paragraph) do
      current_paragraph = story.first_paragraph
      (last_level - 2).times do
        current_paragraph = current_paragraph.next_paragraphs.first
      end
      current_paragraph.add_next(create(:paragraph, content: "Alternative to the last paragraph"))
      last_paragraph = create(:paragraph, content: "Last paragraph; the end.")
      current_paragraph.add_next(last_paragraph)
      last_paragraph
    end
    let!(:first_id) { story.first_paragraph.id }
    let!(:last_id) { last_paragraph.id }
    let!(:last_address) do
      address_from_random = ((first_id + 1)..(first_id + last_level - 2))
                            .map(&:to_s)
                            .join(Story::ADDRESS_SEPARATOR)
      address_from_random + "#{Story::ADDRESS_SEPARATOR}#{last_id}"
    end

    describe "#paragraph_at" do
      it "returns the correct paragraph" do
        found_last_paragraph = story.paragraph_at(last_address)
        expect(found_last_paragraph).to eq last_paragraph
      end
    end

    describe "Paragraph#address" do
      it "returns the correct address" do
        expect(last_paragraph.address).to eq last_address
      end
    end
  end

  describe "#score" do
    let!(:story) do
      the_story = create(:story)
      the_story.first_paragraph
               .add_next(create(:paragraph, auto_likes: 3, auto_dislikes: 2))
      the_story.first_paragraph
               .add_next(create(:paragraph, auto_likes: 1))
      the_story
    end

    it "returns the sum of all paragraph scores" do
      expect(story.score).to eq 2
    end
  end

  describe "#progress" do
    let!(:story) { create(:story, random_paragraphs_count: Paragraph::MAX_LEVEL / 2) }

    it "returns the percentage toward story completion" do
      expect(story.progress).to eq 50
    end
  end
end
