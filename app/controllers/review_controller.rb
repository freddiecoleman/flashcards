class ReviewController < ApplicationController
	before_filter :authorise
	def index
		@flashcard = @current_user.flashcards.first if @flashcard == nil

	end

	def show
		render partial: 'answer'
	end
	
end
