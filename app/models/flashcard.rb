class Flashcard < ActiveRecord::Base
	validates :front, presence: true
	validates :back, presence: true
end
