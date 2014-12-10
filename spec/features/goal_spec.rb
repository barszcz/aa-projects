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

    it "has link to goal page" do
      fill_in "Aim", with: "Private goal"
      choose "Private"
      click_button "Create Goal"
      expect(page).to have_link("Private goal")
    end

  end

  feature "goal page" do

    before(:each) do
      make_goals("goal1", "goal2", "goal3")
      click_link "goal1"
    end
    it "displays correct goal" do

      expect(page).to have_content("goal1")
    end

    it "can change goal completion" do
      expect(page).to have_button("Complete")
    end

    it "it actually changes goal completion" do
      click_button("Complete")
      expect(page).to have_content("Completed")
    end

    it "has button to destroy goal" do
      expect(page).to have_button("Delete goal")
    end

    it "destroys goal" do
      click_button("Delete goal")
      expect(page).to_not have_content("goal1")
      expect(page).to have_content("goal2")
    end

    it "has link to edit page" do
      expect(page).to have_link("Edit goal")
    end

    it "redirects if goal is private and does not belong to user" do
      make_goals("Private goal", public: false)
      click_button("Log out")
      sign_up("user2", "password2")
      visit goal_url(Goal.last)
      expect(page).to_not have_content("Private goal")
    end

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
