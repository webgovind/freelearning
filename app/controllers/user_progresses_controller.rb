class UserProgressesController < ApplicationController
    before_action :authorize_request
    before_action :find_user_progress, only: [:update,:show,:destroy]
  
    def index
        @user_progress = User.find_by!(id: params[:user_id]).user_progress
        render json:@user_progress, status: :ok
    end

    def create
        # debugger
        # @user_progress = User.find_by(id: params[:user_id]).user_progress.new(user_progress_params)
        @user_progress = User.find_by(id: params[:user_id]).build_user_progress(user_progress_params)
        if @user_progress.save
            render json: @user_progress, status: :created
        else
            render json: { errors: @user_progress.errors.full_messages },
                   status: :unprocessable_entity
        end
    end

    def update
        unless @user_progress.update(user_progress_params)  
            render json: { errors: @user_progress.errors.full_messages },
                   status: :unprocessable_entity
        else
            render json: {message: "updated"}, status: :ok           
        end 
    end

    def show
         render json:@user_progress, status: :ok
    end

    def destroy
        if @user_progress.destroy
            render json:{message: "Deleted"}, status: :ok
		end
    end 

    private

    #callbacks
    def find_user_progress
        # debugger
        @user_progress = User.find_by!(id: params[:user_id]).user_progress
       
    end

    #params
    def user_progress_params
        params.permit(:completed, :topic_id)
    end
end
