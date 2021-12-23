require 'rails_helper'

RSpec.describe Paragraph, type: :model do
  describe "#score" do
    let!(:paragraph) { create(:paragraph) }

    it "correctly sums up likes and dislikes" do
      paragraph.reactions << create(:like_reaction)
      paragraph.reactions << create(:dislike_reaction)
      paragraph.reactions << create(:dislike_reaction)
      score = paragraph.score
      expect(score).to eq(-1)
    end
  end

  describe "validation fails" do
    context "when required attributes are blank" do
      let!(:paragraph) { Paragraph.new(position: nil,
                                       content: "") }

      it "is invalid" do
        message = "can't be blank"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:position]).to include message
        expect(paragraph.errors[:content]).to include message
      end
    end

    context "when position is less than 1" do
      let!(:paragraph) { build_stubbed(:paragraph, position: 0) }

      it "is invalid" do
        message = "must be in 1..#{Paragraph::MAX_POSITION}"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:position]).to eq [message]
      end
    end

    context "when position is greater than the maximum" do
      let!(:paragraph) { build_stubbed(:paragraph,
                                       position: Paragraph::MAX_POSITION + 1) }

      it "is invalid" do
        message = "must be in 1..#{Paragraph::MAX_POSITION}"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:position]).to eq [message]
      end
    end

    context "when position is not an integer" do
      let!(:paragraph) { build(:paragraph, position: 1.5) }

      it "is invalid" do
        message = "must be an integer"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:position]).to eq [message]
      end
    end

    context "when content is longer than the maximum" do
      let!(:paragraph) { build_stubbed(:paragraph,
                                       content: "a" * (Paragraph::MAX_LENGTH + 1)) }

      it "is invalid" do
        message = "is too long (maximum is #{Paragraph::MAX_LENGTH} characters)"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:content]).to eq [message]
      end
    end

    context "when score is not an integer" do
      let!(:paragraph) { build(:paragraph, score: 1.5) }

      it "is invalid" do
        message = "must be an integer"
        expect(paragraph).to_not be_valid
        expect(paragraph.errors[:score]).to eq [message]
      end
    end
  end

  describe "default values" do
    let!(:paragraph) { build(:paragraph) }

    it "has a default score of zero" do
      expect(paragraph.score).to eq 0
    end
  end
end
