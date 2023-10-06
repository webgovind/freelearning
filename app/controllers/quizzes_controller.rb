class QuizzesController < ApplicationController
    before_action :authorize_request
    before_action :find_quiz, only: [:update,:show,:destroy]
  
    def index
        # debugger
        @quizzes = Topic.find_by!(id: params[:topic_id]).quizzes.all
        render json:@quizzes, status: :ok
    end

    def create
        # debugger
        @quiz = Topic.find_by!(id: params[:topic_id]).quizzes.new(quiz_params)
        if @quiz.save
            render json: @quiz, status: :created
        else
            render json: { errors: @quizzes.errors.full_messages },
                   status: :unprocessable_entity
        end
    end   

    def update
        unless @quiz.update(quiz_params)  
            render json: { errors: @quiz.errors.full_messages },
                   status: :unprocessable_entity
        else
            render json: {message: "updated"}, status: :ok           
        end 
    end

    def show
         render json:@quiz, status: :ok
    end

    def destroy
        if @quiz.destroy
            render json:{message: "Deleted"}, status: :ok
		end
    end 

    private

    #callbacks
    def find_quiz
        # debugger
        @quiz = Topic.find_by!(id: params[:topic_id]).quizzes.find(params[:id])
    end

    #params
    def quiz_params
        params.permit(:title)
    end
end
