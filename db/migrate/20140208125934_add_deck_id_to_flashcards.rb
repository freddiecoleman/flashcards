class AddDeckIdToFlashcards < ActiveRecord::Migration
  def change
    add_column :flashcards, :deck_id, :integer
    add_index :flashcards, :deck_id
  end

end
