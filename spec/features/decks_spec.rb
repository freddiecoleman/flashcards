require 'spec_helper'

describe "Decks" do
  before do
    register
    create_deck
    @deck = Deck.find_by(name: 'test deck')
    visit decks_path
  end

  describe "displaying decks" do
   it "display decks" do
    page.should have_content 'test deck'
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
        fill_in 'Name', with: 'testing creation of a new deck'
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
          page.should have_content 'testing creation of a new deck'
        end
      end
    end
  end

  describe "editing a deck" do
    describe "PUT /decks" do
    	it "edits a deck" do
    	 click_link 'Edit'

    	 current_path == edit_deck_path(@deck)

    	 find_field('Name').value.should == 'test deck'

  	 	 fill_in 'Name', with: 'testing updating deck'

  	 	 click_button 'Update Deck'
       current_path.should == decks_path
       page.should have_content 'testing updating deck'
  	 end
     it "should not update if name of deck is empty" do
  	   find("#deck_#{@deck.id}").click_link 'Edit'
       fill_in 'Name', with: ''
       click_button 'Update Deck'
       current_path.should == edit_deck_path(@deck)
       page.should have_content 'There was an error updating your deck.'
     end
   end
 end

 describe "deleting a deck" do
  describe "DELETE /decks" do
    it "should delete a deck and all nested flashcards" do
      find("#deck_#{@deck.id}").click_link 'Delete'
      page.should have_content 'Deck has been deleted.'
      page.should have_no_content 'deck name test'
      visit flashcards_path
      page.should have_no_content 'test deck'
    end
  end
 end

 describe "clicking the link to manage flashcards in a deck" do
  it "should go to the page which shows flashcards from the correct deck" do
    find("#deck_#{@deck.id}").click_link 'Manage Flashcards'
    current_path.should == deck_flashcards_path(@deck)
  end
 end
end