class QuestionsController < ApplicationController

	before_action :private_access, except: [:index, :show]

	def index
  @questions= Question.all
end

def new

	@question= Question.new

end

def create
  @question = Question.new(question_params)
  @question.user = current_user
  if @question.save
    redirect_to questions_path, notice: "La pregunta fue publicado con éxito"
  else
    render :new
  end
end

def show
  @question = Question.find(params[:id])
end


def edit
  @question = Question.find(params[:id])
end

def destroy
  question = Question.find(params[:id])
  question.destroy

  redirect_to questions_path, notice: "La pregunta fue eliminada"
end


def update
  @question = Question.find(params[:id])
  if @question.update(question_params)
    redirect_to questions_path, notice: "La pregunta ha sido modificado con éxito"
  else
    render :edit
  end
end







private
  def question_params
    params.require(:question).permit(:title, :description)
  end

end
