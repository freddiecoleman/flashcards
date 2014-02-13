require 'spec_helper'

describe "Flashcards" do

  front_test = 'this is testing the front of a flashcard'
  back_test = 'this is testing the back of a flashcard'
  create_front = 'testing creation front'
  create_back = 'testing creation back'
  update_front = 'testing updating flashcard front'
  update_back = 'testing updating flashcard back'

  before do
    register
    create_deck
    create_flashcard
    @deck = Deck.find_by(name: 'test deck')
    @flashcard = Flashcard.find_by(Front: 'this is testing the front of a flashcard')
    visit flashcards_path
  end

  describe "displaying flashcards" do
   it "display flashcards" do
   	page.should have_content front_test
   	page.should have_content back_test
   end
  end

  describe "flashcard creation" do

    let(:submit) { "Create Flashcard" }

    describe "with invalid information" do
      before { click_button submit }
      it "should display an error message" do
        page.should have_content 'Error: Flashcard must have a front and back.'
      end
      
    end

    describe "with valid information" do
      before do
        fill_in 'Front', with: create_front
        fill_in 'Back', with: create_back
        select('test deck',:from=> 'Deck')
      end

      it "should create a flashcard" do
        expect { click_button submit }.to change(Flashcard, :count).by(1)
      end

      describe "after registration" do
        before { click_button submit }
        it "Should display a successs message" do
          page.should have_content 'Flashcard created.'
        end
        it "Should display the new flashcard" do
          page.should have_content create_front
          page.should have_content create_back
          page.should have_content 'test deck'
        end
      end
    end
  end

  describe "editing a flashcard" do

    let(:submit) { "Update Flashcard" }

    before { find("#flashcard_#{@flashcard.id}").click_link 'Edit' }

    it "should be the correct flashcard" do
      find_field('Front').value.should == front_test
      find_field('Back').value.should == back_test
    end

    describe "with invalid information" do
      before do
        fill_in 'Front', with: ''
        fill_in 'Back', with: ''
        click_button submit
      end
      it "should display an error message" do
        page.should have_content 'There was an error updating your flashcard.'
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Front', with: update_front
        fill_in 'Back', with: update_back
        click_button submit
      end
      it "should display a success message" do
        page.should have_content 'Your flashcard has successfully been updated.'
      end
    	it "should edit the flashcard" do
    		page.should have_content update_front
    		page.should have_content update_back
    	end
    end
  	
  end

  describe "deleting a flashcard" do
    before { find("#flashcard_#{@flashcard.id}").click_link 'Delete' }
    it "should display a success message" do
      page.should have_content 'Flashcard has been deleted.'
    end
  	it "should delete the flashcard" do
  		page.should have_no_content front_test
  		page.should have_no_content back_test
  	end
  end
end