class User < ApplicationRecord
	has_many :posts
	
	attr_accessor :remember_token
	has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:name, presence:true,length:{maximum:50})
	validates(:email, presence:true, length:{maximum:255}, format:{with:VALID_EMAIL_REGEX}, uniqueness:{case_sensitive:false})
	validates(:password, presence:true, length:{minimum:3}, allow_nil:true)


	def self.create_token
		SecureRandom.urlsafe_base64
	end

	def self.encrypt token
		BCrypt::Password.create(token)
	end

	def remember
		self.remember_token = User.create_token
		self.update_attributes(remember_digest: User.encrypt(remember_token))
	end

	def authenticate? token
		digest = self.remember_digest
		BCrypt::Password.new(digest).is_password?(token)
	end

	def mk_admin
		self.update_attribute(:admin, true)
	end

end
