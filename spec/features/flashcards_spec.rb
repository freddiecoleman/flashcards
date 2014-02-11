require 'spec_helper'

describe "Flashcards" do

  before do
    register
    create_deck
    create_flashcard
    @deck = Deck.find_by(name: 'test deck')
    @flashcard = Flashcard.find_by(Front: 'this is testing the front of a flashcard')
  end

  describe "displaying flashcards" do
   it "display some flashcards" do
   	visit flashcards_path
   	page.should have_content 'this is testing the front of a flashcard'
   	page.should have_content 'this is testing the back of a flashcard'
   end
  end

  describe "flashcard creation" do
    before { visit flashcards_path }

    let(:submit) { "Create Flashcard" }

    describe "with invalid information" do
      it "should generate an error message" do
        click_button submit
        page.should have_content 'Error: Flashcard must have a front and back.'
      end
      
    end

    describe "with valid information" do
      it "creates a new flashcard" do

        fill_in 'Front', with: 'testing front'
        fill_in 'Back', with: 'testing back'

        click_button submit

        page.should have_content 'Flashcard created.'
        page.should have_content 'testing front'
        page.should have_content 'testing back'
       end
    end
   
  end

  describe "PUT /flashcards" do
  	it "edits a flashcard" do
  		visit flashcards_path
  		click_link 'Edit'

  		current_path == edit_flashcard_path(@flashcard)

      # check that we are editing the correct flashcard
  		find_field('Front').value.should == 'this is testing the front of a flashcard'
  		find_field('Back').value.should == 'this is testing the back of a flashcard'

      # fill in the new values
  		fill_in 'Front', with: 'testing updating flashcard front'
  		fill_in 'Back', with: 'testing updating flashcard back'
  		click_button 'Update Flashcard'

		  current_path.should == flashcards_path

  		page.should have_content 'testing updating flashcard front'
  		page.should have_content 'testing updating flashcard back'
  	end
  	it "should not update if front or back of flashcard is empty" do
  		visit flashcards_path
  		click_link 'Edit'

      # add an invalid blank value to the front of the card
  		fill_in 'Front', with: ''
  		click_button 'Update Flashcard'

  		current_path.should == edit_flashcard_path(@flashcard)

  		page.should have_content 'There was an error updating your flashcard.'

      # add an invalid blank value to the back of the card
  		fill_in 'Back', with: ''
  		click_button 'Update Flashcard'

  		current_path.should == edit_flashcard_path(@flashcard)
  	end
  end

  describe "DELETE /flashcards" do
  	it "should delete a flashcard" do
  		visit flashcards_path
  		find("#flashcard_#{@flashcard.id}").click_link 'Delete'
  		page.should have_content 'Flashcard has been deleted.'
  		page.should have_no_content 'this is testing the front of a flashcard'
  		page.should have_no_content 'this is testing the back of a flashcard'
  	end
  end

  describe "managing flashcards" do
    it "should go to the page which shows flashcards from the correct deck" do
      visit decks_path
      find("#deck_#{@deck.id}").click_link 'Manage Flashcards'
      current_path.should == deck_flashcards_path(@deck)
    end
  end
end