class SubjectsController < ApplicationController
    before_action :authorize_request
    before_action :find_subject, only: [:update,:show,:destroy]
  
    def index
        @subjects = User.find_by!(id: params[:user_id]).subjects.all
        render json:@subjects, status: :ok
    end

    def create
        # debugger
        @subject = User.find_by!(id: params[:user_id]).subjects.new(subject_params)
        
        if @subject.save
            render json: @subject, status: :created
        else
            render json: { errors: @subjects.errors.full_messages },
                   status: :unprocessable_entity
        end
    end

    def update
        unless @subject.update(subject_params)  
            render json: { errors: @subject.errors.full_messages },
                   status: :unprocessable_entity
        else
            render json: {message: "updated"}, status: :ok           
        end 
    end

    def show
         render json:@subject, status: :ok
    end

    def destroy
        if @subject.destroy
            render json:{message: "Deleted"}, status: :ok
		end
    end 

    private

  
    def find_subject  
        # debugger
        @subject = User.find_by!(id: params[:user_id]).subjects.find(params[:id])
       
    end

    #params for update
    def subject_params
        params.permit(:name)
    end

       
end
