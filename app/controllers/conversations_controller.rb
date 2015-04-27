class ConversationsController < ApplicationController
    def get_by_id
        conversation = Conversation.find_by_id(params[:id])
        if conversation.present?
            render :json => conversation.response_object
        else
            render_error(:resource_not_found)
        end
    end

    def create
        user = @token_results[:user]
        other_user = User.find_by_id(params[:user_id])

        if other_user.present?
            arenas = Arena.for_users(user, other_user)

            if arenas.length == 0
                render_error(:resource_not_found, :resource => :arena) and return
            end

            arena = arenas[0]
            conversation = arena.conversations.create :title => "Untitled Conversation"
            render :json => { :id => conversation.id }
        else
            render_error(:resource_not_found, :resource => :other_user)
        end
    end
end
