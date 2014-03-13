class CreateReviewLogs < ActiveRecord::Migration
  def change
    create_table :review_logs do |t|
      t.integer :user_id
      t.integer :deck_id
      t.integer :score

      t.timestamps
    end
  end
end
