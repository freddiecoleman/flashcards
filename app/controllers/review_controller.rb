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

	#when review a card need to make the new due date = today + the NEW interval.
	# then add the new interval and easiness to the db as well
	# dont need to do anything with the old interval as that is only used on input

	def create
		redirect_to deck_review_index_path(params[:deck_id])
	end

	def show
		
	end
	
end
