class DoubtsController < ApplicationController
    before_action :authorize_request
    before_action :find_doubt, only: [:update,:show,:destroy]
  
    def index
        # debugger
        @doubts = Topic.find_by!(id: params[:topic_id]).doubts.all
        render json:@doubts, status: :ok
    end

    def create
        # debugger
        @doubt = Topic.find_by!(id: params[:topic_id]).doubts.new(doubt_params)
        if @doubt.save
            render json: @doubt, status: :created
        else
            render json: { errors: @doubts.errors.full_messages },
                   status: :unprocessable_entity
        end
    end   

    def update
        unless @doubt.update(doubt_params)  
            render json: { errors: @doubt.errors.full_messages },
                   status: :unprocessable_entity
        else
            render json: {message: "updated"}, status: :ok           
        end 
    end

    def show
         render json:@doubt, status: :ok
    end

    def destroy
        if @doubt.destroy
            render json:{message: "Deleted"}, status: :ok
		end
    end 

    private

    #callbacks
    def find_doubt
        # debugger
        @doubt = Topic.find_by!(id: params[:topic_id]).doubts.find(params[:id])
    end

    #params
    def doubt_params
        params.permit(:question)
    end
end
