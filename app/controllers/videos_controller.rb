class VideosController < ApplicationController
    before_action :authorize_request
    before_action :find_video, only: [:update,:show,:destroy]
  
    def index
        @videos = Topic.find_by!(id: params[:topic_id]).videos.all
        render json:@videos, status: :ok
    end

    def create
        # debugger
        @video = Topic.find_by!(id: params[:topic_id]).videos.new(video_params)
        if @video.save
            render json: @video, status: :created
        else
            render json: { errors: @videos.errors.full_messages },
                   status: :unprocessable_entity
        end
    end   

    def update
        unless @video.update(video_params)  
            render json: { errors: @video.errors.full_messages },
                   status: :unprocessable_entity
        else
            render json: {message: "updated"}, status: :ok           
        end 
    end

    def show
         render json:@video, status: :ok
    end

    def destroy
        if @video.destroy
            render json:{message: "Deleted"}, status: :ok
		end
    end 

    private

    #callbacks
    def find_video
        # debugger
        @video = Topic.find_by!(id: params[:topic_id]).videos.find(params[:id])
        # @subject = User.find_by!(id: params[:user_id]).subjects.find(params[:id]) 
    end

    #params
    def video_params
        params.permit(:title, :url)
    end
end
