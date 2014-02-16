require 'spec_helper'

describe "users" do
  subject { page }
  describe "user registration" do
    before { visit signup_path }

    let(:submit) { "Create User" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Email',    with: 'test@user.com'
        fill_in 'Password', with: 'testpass'
        fill_in 'Password confirmation', with: 'testpass'
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after registration" do
        before { click_button submit }
        it { should have_content 'Thank you for signing up!' }
      end
      
    end
  end

  describe "user login" do
    describe "with invalid login details" do
      before do
        visit login_path
        click_button 'Log In'
      end
      it { should have_content 'Email or password is invalid.' }
      it { should have_link('Login') }
    end
    describe "with valid login details" do
      before { register }
      it { should have_content 'Thank you for signing up!' }
      it { should have_link('Logout') }
    end
  end
end