

class VotesController < ApplicationController

	
	
before_action :private_access
    
    def create
        name_object = params[:commentable_type].capitalize.constantize
        object = name_object.find(params[:commentable_id])
        object.votes.create(user: current_user)
        question = search_question(object)
        redirect_to question_path(question)
    end

    def destroy
        name_object = params[:commentable_type].capitalize.constantize
        object = name_object.find(params[:commentable_id])
        object.votes.where(user: current_user).take.try(:destroy)
        question = search_question(object)
        redirect_to question_path(question)
    end
    
    private
    
        def search_question(object)
            # Se valida si el voto es de un pregunta
            if params[:commentable_type].capitalize == "Question"
                question = Question.find(object.id)
            else
                # Si no es de una pregunta es una respuesta por tanto se busca ha que voto pertenece la respuesta
                question = Question.find(object.question_id)
            end
        end
    
end







=begin

before_action :private_access


 def create
        name_object = params[:votable_type]
        object = name_object.find(params[:votable_id])
        object.votes.create(user: current_user)
        question = search_question(object)
        redirect_to question_path
    end

    def destroy
        name_object = params[:votable_type]
        object = name_object.find(params[:votable_id])
        object.votes.where(user: current_user).take.try(:destroy)
        question = search_question(object)
        redirect_to question_path(question)
    end
    
    private
    
       def search_question
		 if params[:question_id]
		 	 @votable = Question.find(params[:question_id])

      elsif params[:answer_id]
      	@votable = Answer.find(params[:answer_id])

      end
	end

end

    



	before_filter :private_access

	def create
  	@vote = @votable.votes.find(vote_params)
 	@votable.votes.create(user: current_user)

  	redirect_to root_path
	end


	private
	if params[:comment][:commentable_type].capitalize == "Question"
                @question = Question.find(object.id)
            else
                # Si no es de una pregunta es una respuesta por tanto se busca ha que pregunta pertenece la respuesta
                @question = Question.find(object.question_id)
            end


	def vote_params
      params.require(:vote).permit(:votable_type, :votable_id)merge(user: current_user)
  	end

	def search_question(object)
		 if params[:question_id]
		 	 @votable = Question.find(params[:question_id])

      elsif params[:answer_id]
      	@votable = Answer.find(params[:answer_id])

      end
	end

end




=end


 
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

=end

