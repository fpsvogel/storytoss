require 'rails_helper'

RSpec.describe Paragraph, type: :model do
  describe "#score" do
    let!(:downvoted_paragraph) { create(:paragraph, likes: 1, dislikes: 2) }

    it "correctly sums up likes and dislikes" do
      expect(downvoted_paragraph.score).to eq(-1)
    end
  end

  describe "#continuations_sorted" do
    let!(:higher_score) { 10 }
    let!(:continued_paragraph) do
      par = create(:paragraph)
      par.continuations << create(:paragraph, likes: higher_score - 1)
      par.continuations << create(:paragraph, likes: higher_score)
      par
    end

    it "sorts continuations in descending order" do
      expect(continued_paragraph.continuations_sorted.first.score).to eq higher_score
    end
  end

  describe "validation fails" do
    context "when required attributes are blank" do
      let!(:paragraph) { Paragraph.new(content: "") }

      it "is invalid" do
        message = "can't be blank"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:content]).to include message
      end
    end

    context "when the content is longer than the maximum" do
      let!(:paragraph) { build_stubbed(:paragraph,
                                       content: "a" * (Paragraph::MAX_LENGTH + 1)) }

      it "is invalid" do
        message = "is too long (maximum is #{Paragraph::MAX_LENGTH} characters)"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:content]).to eq [message]
      end
    end

    context "when the level is higher than the maximum" do
      let!(:paragraph) do
        current = create(:paragraph)
        (Paragraph::MAX_LEVEL).times do
          continuation = create(:paragraph)
          current.continuations << continuation
          current = continuation
        end
        current
      end

      it "is invalid" do
        message = "exceeded the story length"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:base]).to eq [message]
      end
    end
  end
end
