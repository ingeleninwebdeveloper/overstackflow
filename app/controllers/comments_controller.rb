class CommentsController < ApplicationController

	def create
        # Con commentable_type se trae el nombre de la clase (Question o Answer)
        # capitalize coloca el nombre de la clase la primera en mayuscula
        # constantize vuelve el string en una constante como objeto
        name_object = params[:comment][:commentable_type].capitalize.constantize
        
        # Buscamos el registro de Question o Anserws
        object = name_object.find(params[:comment][:commentable_id])
        
        # Creamos el comentario para el objeto Question o Answer
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
            params.require(:comment).permit(:body).merge(user: current_user)
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
