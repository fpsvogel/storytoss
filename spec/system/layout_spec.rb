require "rails_helper"

RSpec.describe "Site layout", type: :system do
  describe "footer" do
    it "is present" do
      visit stories_index_path
      expect(page).to have_selector('#footer')
    end
  end

  describe "header" do
    it "is present" do
      visit stories_index_path
      expect(page).to have_selector('nav')
    end

    context "when the user is logged out" do
      it "shows Register and Login links, not Logout" do
        visit stories_index_path
        expect(page).to have_link("Register")
        expect(page).to have_link("Log in")
        expect(page).not_to have_link("Log out")
      end
    end

    context "when the user is logged in" do
      let!(:password) { "qwerty" }
      let!(:user) { create(:user, password: password) }

      it "shows Logout link, not Register or Login " do
        login_user(user.email, password)
        visit stories_index_path
        expect(page).to have_link("Log out")
        expect(page).not_to have_link("Register")
        expect(page).not_to have_link("Log in")
      end
    end
  end
end