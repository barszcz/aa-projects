require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      sign_up("test_username", "test_password")
      expect(page).to have_content "test_username"
    end

    it "rejects a blank username/password" do
      sign_up("", "")
      expect(page).to have_content "New user"
      expect(page).to have_content "Username can't be blank"
      expect(page).to have_content "Password can't be blank"
    end

    it "rejects a too-short password" do
      sign_up("test_username", "bad")
      expect(page).to have_content "New user"
      expect(page).to have_content "Password is too short"
    end
  end

end

feature "logging in" do

  it "shows username on the homepage after login"

end

feature "logging out" do

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end
