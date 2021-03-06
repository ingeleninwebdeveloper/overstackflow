class Question < ApplicationRecord

	belongs_to :user
	has_many :answers
	 has_many :votes, as: :votable
	 has_many :comments, as: :commentable


validates :description, presence: true
validates :title, presence: true


 def voted_by?(user)
  votes.exists?(user: user)
end

def self.search(query)
        where("title like ? OR description like ?", "%#{query}%", "%#{query}%") 
    end
end
