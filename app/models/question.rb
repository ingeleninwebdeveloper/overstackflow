class Question < ApplicationRecord

	belongs_to :user
	has_many :answers
	 has_many :votes, as: :votable


#validates :description, presence: true
#validates :title, presence: true


 def voted_by?(user)
  votes.exists?(user: user)
end
end
