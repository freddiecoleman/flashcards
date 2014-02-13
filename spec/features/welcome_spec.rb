require 'spec_helper'

describe "welcome" do
  subject { page }
  describe "home page" do
    before { visit root_path }

    describe "not logged in" do
      it "should display logged out navbar" do
        page.should have_link 'Register'
        page.should have_link 'Login'
      end
      it "should not display logged in user navbar" do
        page.should have_no_link 'Stats'
        page.should have_no_link 'Manage Decks'
        page.should have_no_link 'Manage Flashcards'
      end
    end

    describe "logged in" do
      before { register }
      it "should display logged in user navbar" do
        page.should have_link 'Stats'
        page.should have_link 'Manage Decks'
        page.should have_link 'Manage Flashcards'
      end
      it "should not display logged out navbar" do
        page.should have_no_link 'Register'
        page.should have_no_link 'Login'
      end
    end
  end
end