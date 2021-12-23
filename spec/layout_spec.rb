require "rails_helper"

RSpec.describe "Site layout", type: :system do
  describe "home page" do
    it "has a footer" do
      visit stories_index_path
      expect(page).to have_selector('#footer')
    end

    it "has a header" do
      visit stories_index_path
      expect(page).to have_selector('nav')
    end
  end
end