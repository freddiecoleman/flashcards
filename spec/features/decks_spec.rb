require 'spec_helper'

describe "Decks" do

  name_test = 'test deck'
  create_name = 'testing creation of a new deck'
  update_name = 'testing updating deck'

  before do
    register
    create_deck
    @deck = Deck.find_by(name: name_test)
    visit decks_path
  end

  describe "displaying decks" do
   it "display decks" do
    page.should have_content name_test
   end
  end

  describe "deck creation" do

    let(:submit) { "Create Deck" }

    describe "with invalid information" do
      before { click_button submit }
      it "should display an error message" do
        page.should have_content 'Error: Deck must have a name.'
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Name', with: create_name
      end

      it "should create a deck" do
        expect { click_button submit }.to change(Deck, :count).by(1)
      end

      describe "after creating a new deck" do
        before { click_button submit }
        it "Should display a successs message" do
          page.should have_content 'Deck created.'
        end
        it "Should display the new deck" do
          page.should have_content create_name
        end
      end
    end
  end

  describe "editing a deck" do

    let(:submit) { "Update Deck" }

    before { find("#deck_#{@deck.id}").click_link 'Edit' }

    it "should be the correct deck" do
      find_field('Name').value.should == name_test
    end

    describe "with invalid information" do
      before do
        fill_in 'Name', with: ''
        click_button submit
      end
      it "should display an error message" do
        page.should have_content 'There was an error updating your deck.'
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Name', with: update_name
        click_button submit
      end
      it "should display a success message" do
        page.should have_content 'Your deck has successfully been updated.'
      end
      it "should edit the deck" do
        page.should have_content update_name
      end
    end
 end

 describe "deleting a deck" do
  before { find("#deck_#{@deck.id}").click_link 'Delete' }

  it "should display a success message" do
    page.should have_content 'Deck has been deleted.'
  end

  it "should delete the deck" do
    page.should have_no_content name_test
  end
 end

 describe "clicking the link to manage flashcards in a deck" do
  before { find("#deck_#{@deck.id}").click_link 'Manage Flashcards' }
  it "should go to the page which shows flashcards from the correct deck" do
    current_path.should == deck_flashcards_path(@deck)
  end
 end
end