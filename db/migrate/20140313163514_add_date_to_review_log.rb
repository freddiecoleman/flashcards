class AddDateToReviewLog < ActiveRecord::Migration
  def change
    add_column :review_logs, :date, :datetime
  end
end
