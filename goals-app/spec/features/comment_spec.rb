require 'spec_helper'
require 'rails_helper'

feature "user comments" do

  before(:each) do
    sign_up("test_username", "test_password")
  end

  feature "Posting comments" do

    it "Has a new comment form on a users page" do
      expect(page).to have_content "Post Comment"
      expect(page).to have_selector('#comment_body')
    end

    it "submits comments" do
      fill_in "comment_body", with: "Test comment"
      click_button "Submit comment"
      expect(page).to have_content "Test comment"
    end

    it "does now allow blank comments" do
      click_button "Submit comment"
      expect(page).to have_content "Body can't be blank"
    end

  end

  feature "Displaying comments" do

    before(:each) do
      fill_in "comment_body", with: "Test comment"
      click_button "Submit comment"
      fill_in "comment_body", with: "Test comment2"
      click_button "Submit comment"
      user1 = User.last
    end

    it "displays multiple comments" do
      expect(page).to have_content "Test comment"
      expect(page).to have_content "Test comment2"
    end

    it "displays comment authors" do
      click_button("Log out")
      sign_up("user2", "password2")
      visit user_url(user1)
      fill_in "comment_body", with: "Comment from the second user"
      click_button "Submit comment"
      click_button("Log out")
      sign_in("test_username", "test_password")
      expect(page).to have_content("user2")
      expect(page).to have_content("Test comment2")
    end

    it "doesn't have edit/delete links for others' comments" do
      click_button("Log out")
      sign_up("user2", "password2")
      visit user_url(user1)
      expect(page).to_not have_button "Delete comment"
    end

  end

  feature "Deleting comments" do

    before(:each) do
      fill_in "comment_body", with: "Test comment"
      click_button "Submit comment"
      fill_in "comment_body", with: "Test comment2"
      click_button "Submit comment"
      user1 = User.last
    end

    it "deletes relevant comments" do
      click_button ("delete-#{Comment.last.id}")
      expect(page).to not_have_content "Test comment2"
      expect(page).to have_content "Test comment"
    end

    it "disallows users from deleting others' comments" do
      # click_button("Log out")
      # sign_up("user2", "password2")
      # submit("delete", )
      #TODO FINISH
    end

  end


end





# ###########
# feature "goal comments" do

  before(:each) do
    sign_up("test_username", "test_password")
    make_goals("goal1", "goal2", "goal3")
    click_link "goal1"
  end
#
#   feature "Posting comments" do
#
#     it "Has a new comment page" do
#       expect(page).to have_link "New comment"
#     end
#
#     it "submits comments" do
#       fill_in "comment_body", with: "Test comment"
#       click_button "Submit comment"
#       expect(page).to have_content "Test comment"
#     end
#
#     it "does now allow blank comments" do
#       click_button "Submit"
#       expect(page).to have_content "comment_body can't be blank"
#     end
#
#   end
#
#   feature "Deleting comments" do
#
#     it "deletes relevant comments" do
#       fill_in "comment_body", with: "Test comment"
#       click_button "Submit"
#       fill_in "comment_body", with: "Test comment2"
#       click_button "Submit"
#       click_button "Delete Test comment"
#       expect(page).to not_have_content "Test comment"
#       expect(page).to have_content "Test comment"
#     end
#
#   end
#
# end
