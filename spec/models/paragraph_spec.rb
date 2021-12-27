require 'rails_helper'

RSpec.describe Paragraph, type: :model do
  describe "#score" do
    let!(:paragraph) do
      create(:paragraph, auto_likes: 1, auto_dislikes: 2)
    end

    it "correctly sums up likes and dislikes" do
      expect(paragraph.score).to eq(-1)
    end
  end

  describe "#next_paragraphs_sorted" do
    let!(:higher_score) { 10 }
    let!(:paragraph) do
      par = create(:paragraph)
      par.nexts << create(:paragraph, auto_likes: higher_score - 1)
      par.nexts << create(:paragraph, auto_likes: higher_score)
      par
    end

    it "sorts next paragraphs in descending order" do
      expect(paragraph.next_paragraphs_sorted.first.score).to eq higher_score
    end
  end

  describe "#add_next" do
    let!(:next_paragraph) { create(:paragraph) }
    let!(:previous_by_paragraph) do
      par = create(:paragraph)
      par.add_next(next_paragraph)
      par
    end
    let!(:previous_by_content_and_author) do
      par = create(:paragraph)
      par.add_next(content: next_paragraph.content, author: next_paragraph.author)
      par
    end

    it "accepts either a paragraph or attributes" do
      by_par = previous_by_paragraph.next_paragraphs
      by_attr = previous_by_content_and_author.next_paragraphs
      expect(by_par.count).to eq by_attr.count
      expect(by_par.map(&:content)).to eq by_attr.map(&:content)
      expect(by_par.map(&:author)).to eq by_attr.map(&:author)
    end

    it "returns the next paragraph" do
      expect(create(:paragraph).add_next(next_paragraph)).to eq next_paragraph
    end
  end

  describe "adding a like when a dislike exists from the same user" do
    let!(:paragraph) { create(:paragraph) }

    it "removes the dislike automatically" do
      paragraph.add_like(user: paragraph.author)
      expect(paragraph.likes.count).to eq 1
      paragraph.add_dislike(user: paragraph.author)
      expect(paragraph.likes.count).to eq 0
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
          current = current.add_next(create(:paragraph))
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
