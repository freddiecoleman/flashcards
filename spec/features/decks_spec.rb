require 'spec_helper'

describe "Decks" do
  
  before do
  	@deck = Deck.create name: 'deck name test'
  end

  describe "GET /decks" do
   it "display decks" do
   	
   	visit decks_path
   	page.should have_content 'deck name test'
   end

   it "creates a new deck" do
   	visit decks_path
   	fill_in 'Name', with: 'testing creation of a new deck'

   	click_button 'Create Deck'

	current_path.should == decks_path

	page.should have_content 'testing creation of a new deck'
   end
  end

  describe "PUT /decks" do
  	it "edits a deck" do
  		visit decks_path
  		click_link 'Edit'

  		current_path == edit_deck_path(@deck)

  		find_field('Name').value.should == 'deck name test'

  		fill_in 'Name', with: 'testing updating deck'

  		click_button 'Update Deck'

		current_path.should == decks_path

  		page.should have_content 'testing updating deck'
  	end
  	it "should not update if name of deck is empty" do
  		visit decks_path
  		click_link 'Edit'

  		fill_in 'Name', with: ''

  		click_button 'Update Deck'

  		current_path.should == edit_deck_path(@deck)

  		page.should have_content 'There was an error updating your deck.'
  	end
  end

  describe "DELETE /decks" do
  	it "should delete a deck" do
  		visit decks_path
  		find("#deck_#{@deck.id}").click_link 'Delete'
  		page.should have_content 'Deck has been deleted.'
  		page.should have_no_content 'deck name test'
  	end
  end
end
