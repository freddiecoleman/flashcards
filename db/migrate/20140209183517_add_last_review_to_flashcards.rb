class AddLastReviewToFlashcards < ActiveRecord::Migration
  def change
    add_column :flashcards, :last_review, :datetime
  end
end
