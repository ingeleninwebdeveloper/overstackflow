class QuestionsController < ApplicationController

	before_action :private_access, except: [:index, :show]

	def index
    if params[:search]
      @questions = Question.search(params[:search]).order("created_at DESC")
    else
      @questions = Question.all.order("created_at DESC")
    end
  end

  def show
    @question = Question.find(params[:id])
    # Este variable de instancia se crea para validar el modelo de comentarios a la hora de crearlos
    @comment = Comment.new
    # Este variable de instancia se crea para validar el modelo de respuestas a la hora de crearlos
    @answer = Answer.new
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_parameter)
    @question.user = current_user
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end
  
  private

    def question_parameter
      params.require(:question).permit(:title, :description)
    end
  
end
