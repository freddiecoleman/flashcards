class CreateFlashcards < ActiveRecord::Migration
  def change
    create_table :flashcards do |t|
      t.text :front
      t.text :back

      t.timestamps
    end
  end
end
