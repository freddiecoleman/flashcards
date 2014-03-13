class ReviewController < ApplicationController
	before_filter :authorise
	def index
		if params[:deck_id] != nil
      if !@flashcard = @current_user.flashcards.where("due <= ? AND deck_id = ?", Time.now, params[:deck_id]).order(:last_review).first
        redirect_to decks_path, notice: "No cards in this deck are ready for review."
      end
    else
      redirect_to decks_path, notice: "You need to select a deck to review."
    end
  end

	#when review a card need to make the new due date = today + the NEW interval.
	# then add the new interval and easiness to the db as well
	# dont need to do anything with the old interval as that is only used on input

	def update
		@flashcard = Flashcard.find(params[:id])
		if params[:response] == "Again"
			response = 0
		elsif params[:response] == "Hard"
			response = 1
		elsif params[:response] == "Good"
			response = 2
		elsif params[:response] == "Easy"
			response = 3
		end

		sm2 = SpacedRepetition::Sm2.new(response, @flashcard.interval, @flashcard.ease_factor)
		@flashcard.update_attributes interval: sm2.interval, ease_factor: sm2.easiness_factor, due: Time.now+sm2.interval.days, last_review: Time.now
		redirect_to deck_review_index_path(params[:deck_id])

    # log the review in the review logs
    ReviewLog.create(:user_id => params[:id], :score => response, :deck_id => params[:deck_id], :date => Time.now)
	end

	def show
		
	end
	
end
