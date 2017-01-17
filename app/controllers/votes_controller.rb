
class VotesController < ApplicationController



	before_filter :load_votable

	@vote=@votable.votes.create(params_vote)
	

	def create
  	@vote = @votable.votes.find(params[:vote])
 	@votable.create(user: current_user)

  	redirect_to root_path
	end

	private

	def load_votable
		 if params[:question_id]
		 	 @votable = Question.find(params[:question_id])

      elsif params[:answer_id]
      	@votable = Answer.find(params[:answer_id])

      end
	end

end


=begin


 

def create
  question = Question.find(params[:question_id])
  question.votes.create(user: current_user)

  redirect_to root_path
end

def destroy
  question = Question.find(params[:question_id])
  question.votes.where(user: current_user).take.try(:destroy)

  redirect_to root_path
end

end

