require 'spec_helper'

describe "review" do

  before do
    register
    create_deck
    create_flashcard
    @deck = Deck.find_by(name: 'test deck')
  end

  describe "with valid deck id" do
    before do
      visit deck_review_index_path(@deck)
      @flashcard = @deck.flashcards.where("due <= ? AND deck_id = ?", Time.now, @deck.id).order(:last_review).first
    end
    it "reviews correct deck" do
      page.should have_content @flashcard.front
      page.should have_content @flashcard.back
    end
    it "logs review into stats table" do
      expect { click_button "Hard" }.to change(ReviewLog, :count).by(1)
    end
  end

  describe "without deck id" do
    before { visit deck_review_index_path(deck_id: 0) }
    it "displays an error message" do
      page.should have_content 'No cards in this deck are ready for review.'
    end
  end

  describe "user doesnt own the deck" do

  end
end