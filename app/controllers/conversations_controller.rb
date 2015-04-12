class ConversationsController < ApplicationController
    def get_by_id
        conversation = Conversation.find_by_id(params[:id])
        if conversation.present?
            render :json => conversation.response_object
        else
            render :json => { :error => "No such conversation." }
        end
    end
end
