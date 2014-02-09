class ReviewController < ApplicationController
	before_filter :authorise
	def index
		if params[:deck_id] != nil
	      if !@flashcard = @current_user.flashcards.where("due <= ? AND deck_id = ?", Time.now, params[:deck_id]).first
	      	redirect_to decks_path, notice: "No cards in this deck are ready for review."
	      end
	    else
	      redirect_to decks_path, notice: "You need to select a deck to review."
	    end
	end

	def show
		
	end
	
end
