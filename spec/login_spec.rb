require "rails_helper"

RSpec.describe "Login", type: :system do
  context "when email and password are valid" do
    let!(:password) { "qwerty" }
    let!(:user) { create(:user, password: password) }

    it "logs in a user" do
      visit login_path
      fill_in 'email',    with: user.email
      fill_in 'password', with: password
      find('input[type=submit]').click
      expect(page).to have_selector('div.alert.alert-success')
    end
  end
end