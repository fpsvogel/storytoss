require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation fails" do
    context "when required attributes are blank" do
      let!(:user) { User.new(username: nil,
                             email: nil,
                             password: nil,
                             password_confirmation: nil) }

      it "is invalid" do
        message = "can't be blank"
        expect(user).to_not be_valid
        expect(user.errors[:username]).to include message
        expect(user.errors[:email]).to include message
        expect(user.errors[:password]).to include message
        expect(user.errors[:password_confirmation]).to include message
      end
    end

    context "when the password is too short" do
      let!(:user) { build_stubbed(:user, password: "ab12!") }
      it "is invalid" do
        message = "is too short (minimum is 6 characters)"
        expect(user).to_not be_valid
        expect(user.errors[:password]).to eq [message]
      end
    end

    context "when the password confirmation does not match the password" do
      let!(:user) { build_stubbed(:user, password: "qwerty",
                                        password_confirmation: "azerty") }
      it "is invalid" do
        message = "doesn't match Password"
        expect(user).to_not be_valid
        expect(user.errors[:password_confirmation]).to include message
      end
    end

    context "when the username contains nonalphanumeric, non-hyphen characters" do
      let!(:user) { build_stubbed(:user, username: "some_user") }
      it "is invalid" do
        message = "must include only lowercase letters, numbers, and hyphens"
        expect(user).to_not be_valid
        expect(user.errors[:username]).to eq [message]
      end
    end

    context "when the username contains capital letters" do
      let!(:user) { build_stubbed(:user, username: "User123") }
      it "is invalid" do
        message = "must include only lowercase letters, numbers, and hyphens"
        expect(user).to_not be_valid
        expect(user.errors[:username]).to eq [message]
      end
    end

    context "when the username is too long" do
      let!(:user) { build_stubbed(:user, username: "a" * 31) }
      it "is invalid" do
        message = "is too long (maximum is 30 characters)"
        expect(user).to_not be_valid
        expect(user.errors[:username]).to eq [message]
      end
    end

    context "when the username is not unique" do
      let!(:user1) { create(:user, username: "user") }
      let!(:user2) { build_stubbed(:user, username: "user") }
      it "is invalid" do
        message = "has already been taken"
        expect(user2).to_not be_valid
        expect(user2.errors[:username]).to eq [message]
      end
    end

    context "when the email address is invalid" do
      let!(:user) { build_stubbed(:user, email: "user (at) example.com") }
      it "is invalid" do
        message = "must be a valid email address"
        expect(user).to_not be_valid
        expect(user.errors[:email]).to eq [message]
      end
    end

    context "when the email address is too long" do
      let!(:user) { build_stubbed(:user, email: "#{"a" * (256 - 12)}@example.com") }
      it "is invalid" do
        message = "is too long (maximum is 255 characters)"
        expect(user).to_not be_valid
        expect(user.errors[:email]).to eq [message]
      end
    end

    context "when the email address is not unique" do
      let!(:user1) { create(:user, email: "user@example.com") }
      let!(:user2) { build_stubbed(:user, email: "user@example.com") }
      it "is invalid" do
        message = "has already been taken"
        expect(user2).to_not be_valid
        expect(user2.errors[:email]).to eq [message]
      end
    end
  end
end
