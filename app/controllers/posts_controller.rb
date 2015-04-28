class PostsController < ApplicationController
    RESPONSE_MESSAGES = {
        :no_such_conversation => "No such conversation.",
        :no_such_post => "No such post.",
        :invalid_post => "We couldn't parse your post!",
        :successful_post => "Post successfully saved."
    }

    def create
        conversation = Conversation.find_by_id(params[:conversation_id])
        author = get_authenticated_user
        if conversation.nil?
            render :json => { :error => RESPONSE_MESSAGES[:no_such_conversation] }
        elsif !params_contain_text(params)
            render :json => { :error => RESPONSE_MESSAGES[:invalid_post] }
        else
            conversation.posts.create :text => params[:text], :author => author
            render :json => { :success => RESPONSE_MESSAGES[:successful_post] }
        end
    end

    def edit
        if !params_contain_text(params)
            render :json => { :error => RESPONSE_MESSAGES[:invalid_post] }
        else
            begin
                Post.update params[:post_id], :text => params[:text]
                render :json => { :success => RESPONSE_MESSAGES[:successful_post] }
            rescue
                render :json => { :error => RESPONSE_MESSAGES[:no_such_post] }
            end
        end
    end

    def params_contain_text(params)

        return params[:text].present?
    end
end
