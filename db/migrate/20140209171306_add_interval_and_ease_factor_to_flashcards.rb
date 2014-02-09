class AddIntervalAndEaseFactorToFlashcards < ActiveRecord::Migration
  def change
    add_column :flashcards, :interval, :integer
    add_column :flashcards, :ease_factor, :decimal
  end
end
