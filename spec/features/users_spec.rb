require 'spec_helper'

describe "users" do
  describe "user registration" do
    it "should create a new user" do
      # Register a new user to be used during the testing process
      visit signup_path
      fill_in 'Email', with: 'testuser'
      fill_in 'Password', with: 'testpass'
      fill_in 'Password confirmation', with: 'testpass'
      click_button 'Create User'
      current_path.should == root_path
      page.should have_content 'Thank you for signing up!'
    end
  end

  describe "user login" do
    it "should log in" do
      #login
      visit login_path
      fill_in 'Email', with: 'testuser'
      fill_in 'Password', with: 'testpass'
      click_button 'Log In'
    end
  end
end