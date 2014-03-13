class User < ActiveRecord::Base
	has_secure_password
	validates_uniqueness_of :email
	before_create { generate_token(:auth_token) }
	has_many :decks, dependent: :destroy
	has_many :flashcards, through: :decks
  has_many :review_logs, through: :decks

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end
end
