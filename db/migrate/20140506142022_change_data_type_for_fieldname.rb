class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def self.up
    change_table :review_logs do |t|
      t.change :date, :date
    end
  end
  def self.down
    change_table :review_logs do |t|
      t.change :date, :datetime
    end
  end
end