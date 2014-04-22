class WelcomeController < ApplicationController
  before_filter :current_user
  def index

    @deck = Deck.new if current_user
    @decks = @current_user.decks.to_a if current_user
  end
end
