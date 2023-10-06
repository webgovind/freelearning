class QuizQuestionsController < ApplicationController
    before_action :authorize_request
    before_action :find_quiz_question, only: [:update,:show,:destroy]
  
    def index
        @quiz_questions = Quiz.find_by!(id: params[:quiz_id]).quiz_questions.all
        render json:@quiz_questions, status: :ok
    end

    def create
        # debugger
        @quiz_question = Quiz.find_by!(id: params[:quiz_id]).quiz_questions.new(quiz_question_params)
        
        if @quiz_question.save
            render json: @quiz_question, status: :created
        else
            render json: { errors: @quiz_questions.errors.full_messages },
                   status: :unprocessable_entity
        end
    end

    def update
        unless @quiz_question.update(quiz_question_params)  
            render json: { errors: @quiz_question.errors.full_messages },
                   status: :unprocessable_entity
        else
            render json: {message: "updated"}, status: :ok           
        end 
    end

    def show
         render json:@quiz_question, status: :ok
    end

    def destroy
        if @quiz_question.destroy
            render json:{message: "Deleted"}, status: :ok
		end
    end 

    private

    #callbacks
    def find_quiz_question  
        # debugger
        @quiz_question = Quiz.find_by!(id: params[:quiz_id]).quiz_questions.find(params[:id])
       
    end

    #params
    def quiz_question_params
        params.permit(:text, :correct_answer)
    end 
end
