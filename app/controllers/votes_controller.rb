

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








