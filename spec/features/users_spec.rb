require 'spec_helper'

describe "users" do
  describe "user registration" do
    it "should create a new user and log in" do
      # Register a new user to be used during the testing process
      visit signup_path
      fill_in 'Email', with: 'testuser'
      fill_in 'Password', with: 'testpass'
      fill_in 'Password confirmation', with: 'testpass'
      click_button 'Create User'
      current_path.should == root_path
      page.should have_content 'Thank you for signing up!'

      # log in
      visit login_path
      fill_in 'Email', with: 'testuser'
      fill_in 'Password', with: 'testpass'
      click_button 'Log In'
      current_path.should == root_path
      page.should have_content 'Logged in!'
    end
  end
end