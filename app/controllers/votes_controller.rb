

class VotesController < ApplicationController


=begin
	before_filter :load_votable

	def create
  	@vote = @votable.votes.find(params[:vote])
 	@votable.votes.create(vote_params)

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

	def vote_params
      params.require(:vote).permit(:votable_type, :votable_id, user_id: ?)
end

=end





 

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

