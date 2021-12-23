require "rails_helper"

RSpec.describe "Registration", type: :system do
  context "when username, email, and password are valid" do
    it "creates a user" do
      visit register_path
      fill_in 'user_username',              with: "user123"
      fill_in 'user_email',                 with: "user@example.jp"
      fill_in 'user_password',              with: "qwerty"
      fill_in 'user_password_confirmation', with: "qwerty"
      expect do
        find('input[type=submit]').click
      end.to change { User.count }.by(1)
    end
  end
end