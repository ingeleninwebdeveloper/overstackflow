class Question < ApplicationRecord

	belongs_to :user
	has_many :answers

validates :description, presence: true
validates :title, presence: true
end
