class NotesController < ApplicationController
    before_action :authorize_request
    before_action :find_note, only: [:update,:show,:destroy]
  
    def index
        # debugger
        @note = Topic.find_by!(id: params[:topic_id]).note
        render json:@note, status: :ok
    end

    def create
        # debugger
        @note = Topic.find_by!(id: params[:topic_id]).build_note(note_params)
        if @note.save
            render json: @note, status: :created
        else
            render json: { errors: @note.errors.full_messages },
                   status: :unprocessable_entity
        end
    end   

    def update
        unless @note.update(note_params)  
            render json: { errors: @note.errors.full_messages },
                   status: :unprocessable_entity
        else
            render json: {message: "updated"}, status: :ok           
        end 
    end

    def show
         render json:@note, status: :ok
    end

    def destroy
        if @note.destroy
            render json:{message: "Deleted"}, status: :ok
		end
    end 

    private

 
    def find_note
        # debugger
        @note = Topic.find_by!(id: params[:topic_id]).note
    end    
    

    #params
    def note_params
        params.permit(:content)
    end
end
