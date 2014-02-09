class Flashcard < ActiveRecord::Base
	include SpacedRepetition
	validates :front, presence: true
	validates :back, presence: true
	belongs_to :deck
	before_create :default_values

	def due_in
		if self.due > Time.now
			"in " + Helpers.distance_of_time_in_words(Time.now, self.due, include_seconds: true)
		else
			"Due"
		end
	end

private

    def default_values
      self.due ||= Time.now
      self.interval ||= 1
      self.ease_factor ||= 2.6
    end
    module Helpers
		extend ActionView::Helpers::DateHelper
	end
end
