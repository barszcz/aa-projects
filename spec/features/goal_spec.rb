require 'spec_helper'
require 'rails_helper'


feature "goals" do

  before(:each) do
    sign_up("test_username", "test_password")
    visit new_goal_url
  end

  feature "creating a new goal" do

    it "has a new goal page" do
      expect(page).to have_content "New Goal"
    end


    it "allows users to submit goals" do
      expect(page).to have_button "Create Goal"
    end


    it "rejects blank goals" do
      fill_in "Aim", with: ""
      click_button "Create Goal"
      expect(page).to have_content "Aim can't be blank"
    end


  end

  feature "display appropriate goals on user show page" do

    it "displays new goals made by user" do
      fill_in "Aim", with: "Sample goal"
      choose "Public"
      click_button "Create Goal"
      expect(page).to have_content "Sample goal"
    end


    it "does not display private goals to other users" do
      fill_in "Aim", with: "Private goal"
      choose "Private"
      click_button "Create Goal"
      click_button "Log out"
      sign_up("user2", "password2")
      visit user_url(User.last)
      expect(page).to_not have_content("Private goal")
    end


    it "displays private goals to self" do
      fill_in "Aim", with: "Private goal"
      choose "Private"
      click_button "Create Goal"
      expect(page).to have_content("Private goal")
    end

    it "has link to goals page"

  end

  feature "goal page" do

    it "displays correct goal"

    it "can change goal completion"

    it "has button to destroy goal"

    it "destroys goal"

    it "has link to edit page"

    it "redirects if goal is private does not belong to user"

    it "does not redirect if goal is public"

    it "does not show a link to edit or destroy for wrong user"

  end

  feature "edit page" do

    it "fills form with current information"

    it "properly updates the user's goals"

    it "redirects users who can't edit the goal"

    it "can change goal completion"


  end
end
