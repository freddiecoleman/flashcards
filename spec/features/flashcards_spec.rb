require 'spec_helper'

describe "Flashcards" do

  before do
    @deck = Deck.create name: 'test deck'
  	@flashcard = Flashcard.create front: 'this is testing the front of a flashcard', back: 'this is testing the back of a flashcard', deck_id: @deck.id
  end

  describe "GET /flashcards" do
   it "display some flashcards" do
   	
   	visit flashcards_path
   	page.should have_content 'this is testing the front of a flashcard'
   	page.should have_content 'this is testing the back of a flashcard'
   end

   it "creates a new flashcard" do
   	visit flashcards_path
   	fill_in 'Front', with: 'testing creation of a flashcard front'
   	fill_in 'Back', with: 'testing creation of a flashcard back'

   	click_button 'Create Flashcard'

	current_path.should == flashcards_path

	page.should have_content 'testing creation of a flashcard front'
	page.should have_content 'testing creation of a flashcard back'
   end
  end

  describe "PUT /flashcards" do
  	it "edits a flashcard" do
  		visit flashcards_path
  		click_link 'Edit'

  		current_path == edit_flashcard_path(@flashcard)

  		find_field('Front').value.should == 'this is testing the front of a flashcard'
  		find_field('Back').value.should == 'this is testing the back of a flashcard'

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

  		fill_in 'Front', with: ''

  		click_button 'Update Flashcard'

  		current_path.should == edit_flashcard_path(@flashcard)

  		page.should have_content 'There was an error updating your flashcard.'

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
end