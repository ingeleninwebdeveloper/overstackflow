class CommentsController < ApplicationController

	def create
        
        name_object = params[:comment][:commentable_type].capitalize.constantize
        
        object = name_object.find(params[:comment][:commentable_id])
        
        @comment = object.comments.new(comments_params)
        
        @answer = Answer.new
        
        if @comment.save
            search_question(object)
            redirect_to question_path(@question) 
        else
            search_question(object)
            render "questions/show"
        end
    end
    
    private
    
        def comments_params
            params.require(:comment).permit(:description).merge(user: current_user)
        end
        
        def search_question(object)
            # Se valida si el comentario es de un pregunta
            if params[:comment][:commentable_type].capitalize == "Question"
                @question = Question.find(object.id)
            else
                # Si no es de una pregunta es una respuesta por tanto se busca ha que pregunta pertenece la respuesta
                @question = Question.find(object.question_id)
            end
        end
    

end
