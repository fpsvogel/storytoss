require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "#paragraph_at" do
    let!(:last_level) { 6 }
    let!(:last_contents) { ["And then there were none.", "And then there were still a few."] }
    let!(:story) do
      the_story = create(:story, random_paragraphs_count: last_level - 1)
      paragraph = the_story.first_paragraph
      (last_level - 2).times do
        paragraph = paragraph.continuations.first
      end
      paragraph.continuations << create(:paragraph, content: last_contents.first)
      last_paragraph = create(:paragraph, content: last_contents.second)
      paragraph.continuations << last_paragraph
      @last_id = last_paragraph.id
      the_story
    end
    let!(:first_paragraph_id) { story.first_paragraph.id }
    let!(:last_paragraph_id) { @last_id }

    it "returns the correct paragraph" do
      last_paragraph = story.paragraph_at(last_branch_id)
      expect(last_paragraph.content).to eq last_contents.second
    end

    private

    def last_branch_id
      random_branch_id = ((first_paragraph_id + 1)..(first_paragraph_id + last_level - 2))
                          .map(&:to_s)
                          .join(Story::BRANCH_ID_SEPARATOR)
      random_branch_id +
        "#{Story::BRANCH_ID_SEPARATOR}#{last_paragraph_id}"
    end
  end
end
