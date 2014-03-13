class ReviewLog < ActiveRecord::Base
  belongs_to :user
  before_create :default_values

private

  def default_values
    self.date ||= Time.now
    end
    module Helpers
    extend ActionView::Helpers::DateHelper
  end

end
