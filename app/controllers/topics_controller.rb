class TopicsController < ApplicationController
    before_action :authorize_request
    before_action :find_topic, only: [:update,:show,:destroy]
  
    def index
        @topics = Subject.find_by!(id: params[:subject_id]).topics.all
        render json:@topics, status: :ok
    end

    def create
        # debugger
        @topic = Subject.find_by!(id: params[:subject_id]).topics.new(topic_params)
        # user = User.find_by(id: params[:user_id])
        # subject = user.subjects.find_by(id: params[:subject_id])
        # topic = subject.topics.new(topic_params)
        if @topic.save
            render json: @topic, status: :created
        else
            render json: { errors: @topics.errors.full_messages },
                   status: :unprocessable_entity
        end
    end   

    def update
        unless @topic.update(topic_params)  
            render json: { errors: @topic.errors.full_messages },
                   status: :unprocessable_entity
        else
            render json: {message: "updated"}, status: :ok           
        end 
    end

    def show
         render json:@topic, status: :ok
    end

    def destroy
        if @topic.destroy
            render json:{message: "Deleted"}, status: :ok
		end
    end 

    private

    #callbacks
    def find_topic
        # debugger
        @topic = Subject.find_by!(id: params[:subject_id]).topics.find(params[:id])
        # @subject = User.find_by!(id: params[:user_id]).subjects.find(params[:id]) 
    end

    #params
    def topic_params
        params.permit(:name)
    end
end
