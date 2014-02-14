class DecksController < ApplicationController
  before_filter :authorise
  
  def index
  	@deck = Deck.new
  	@decks = @current_user.decks.to_a
  end

  def create
    if deck_params[:name].present?
      @current_user.decks.create deck_params
      redirect_to :back, notice: 'Deck created.'
    else
      redirect_to :back, notice: 'Error: Deck must have a name.'
    end
  end

  def edit
  	@deck = Deck.find params[:id]
  end

  def update
  	deck = Deck.find params[:id]
  	if deck.update_attributes deck_params
  		redirect_to decks_path, notice: 'Your deck has successfully been updated.'
  	else
  		redirect_to :back, notice: 'There was an error updating your deck.'
  	end
  end

  def destroy
    @deck = Deck.find params[:id]
  	@deck.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Deck has been deleted.' }
      format.js
    end
  end

  def show
    redirect_to decks_path, notice: "You need to select a deck to review."
  end

  def deck_params
    params.require(:deck).permit(:name)
  end
end
