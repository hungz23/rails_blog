class User < ActiveRecord::Base
	has_many :entries, dependent: :destroy
	before_save {self.email =  email.downcase}
	validates :name, presence: true, length: {maximum: 64}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX},
			   uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 6 }, allow_blank: true
	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Defines a proto-feed.
	# See "Following users" for the full implementation.
	def feed
		Entry.where("user_id = ?", id)
	end
end
