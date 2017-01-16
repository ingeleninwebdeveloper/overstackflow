class User < ApplicationRecord
	has_secure_password validations: false

	has_many :questions
	has_many :answers


	validates :email, uniqueness: true, format: /@/
validates :password, presence: true, on: :create
validates :password, length: { in: 6..20 }, allow_nil: true
validates :name, presence: true
end
