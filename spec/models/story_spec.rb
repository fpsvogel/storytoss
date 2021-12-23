require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "#paragraphs_at" do
    let!(:last_position) { 6 }
    let!(:last_likes) { [1, 2] }
    let!(:last_contents) { ["And then there were none.", "And then there were still a few."] }
    let!(:story) do
      create(:story, random_paragraphs_count: last_position - 1,
                     manual_contents: last_contents,
                     manual_likes: last_likes,
                     manual_positions: [last_position, last_position])
      end

    it "returns the correct paragraphs" do
      last_paragraphs = story.paragraphs_at(last_position)
      expect(last_paragraphs.count).to eq last_contents.count
      expect(last_paragraphs.to_a.map(&:content).sort).to eq last_contents.sort
    end

    it "returns the paragraphs in descending order of score" do
      at_last = story.paragraphs_at(last_position)
      expect(at_last.first.score).to eq last_likes.max
    end
  end
end
