require 'spec_helper'

describe "welcome" do

  register_link = 'Register'
  login_link = 'Login'
  stats_link = 'Stats'
  manage_decks_link = 'Manage Decks'
  manage_flashcards_link = 'Manage Flashcards'

  subject { page }
  describe "home page" do
    before { visit root_path }

    describe "not logged in" do
      it "should display logged out navbar" do
        page.should have_link register_link
        page.should have_link login_link
      end
      it "should not display logged in user navbar" do
        page.should have_no_link stats_link
        page.should have_no_link manage_decks_link
        page.should have_no_link manage_flashcards_link
      end
    end

    describe "logged in" do
      before do 
        register
        visit root_path
      end
      it "should display logged in user navbar" do
        page.should have_link stats_link
        page.should have_link manage_decks_link
        page.should have_link manage_flashcards_link
      end
      it "should not display logged out navbar" do
        page.should have_no_link register_link
        page.should have_no_link login_link
      end
    end
  end
end