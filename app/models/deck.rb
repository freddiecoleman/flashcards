class Deck < ActiveRecord::Base
	validates :name, presence: true
	has_many :flashcards, dependent: :destroy
  has_many :review_logs, dependent: :destroy
	belongs_to :user
end
