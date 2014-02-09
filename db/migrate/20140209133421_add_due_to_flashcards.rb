class AddDueToFlashcards < ActiveRecord::Migration
  def change
    add_column :flashcards, :due, :datetime
  end
end
