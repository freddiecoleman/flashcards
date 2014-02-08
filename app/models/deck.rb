class Deck < ActiveRecord::Base
	validates :name, presence: true
end
