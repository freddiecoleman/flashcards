class RemoveUserIdFromReviewLog < ActiveRecord::Migration
  def change
    remove_column :review_logs, :user_id, :integer
  end
end
