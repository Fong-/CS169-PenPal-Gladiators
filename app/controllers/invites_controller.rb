class InvitesController < ActionController::Base
    ERROR_MESSAGES = {
        :already_exists => "already exists",
        :not_exists => "does not exist",
        :invalid_parameters => "invalid parameters"
    }

    def send_request()
        current_user = params[:my_id]
        to_user = params[:to_id]
        if Invite.where(:from_id => current_user.to_i, :to_id => to_user.to_i).count == 0
            new_invite = Invite.new
            new_invite.from_id = current_user.to_i
            new_invite.to_id = to_user.to_i
            new_invite.status = "pending"
            new_invite.save
            render :json => {:success => new_invite}
        else
            render :json => {:error => ERROR_MESSAGES[:already_exists] }
        end
    end

    def incoming_requests()
        result = []
        for invite in Invite.where(:to_id => params[:my_id].to_i)
            corresponding_user = User.where(:id => invite.to_id)
            if corresponding_user.empty?
                # Commented out because Angular constantly polls this; polling
                # when there are no incoming_requests is not an error
                # render :json => {:error => ERROR_MESSAGES[:not_exists]}
                return
            end
            corresponding_user = corresponding_user.first
            result.push({:username => corresponding_user.username, :from_id => invite.from_id, :to_id => invite.to_id, :status => invite.status})
        end
        render :json => result
    end

    def modify_request()
        if params[:status] != "accept" and params[:status] != "decline"
            render :json => {:error => ERROR_MESSAGES[:invalid_parameters] }
            return
        end
        current_invite = Invite.where(:from_id => params[:from_id].to_i, :to_id => params[:my_id].to_i)
        if current_invite.empty?
            render :json => {:error => ERROR_MESSAGES[:not_exists] }
            return
        end
        current_invite = current_invite.first
        current_invite.status = params[:status]
        current_invite.save
        if params[:status] == "accept"
            new_arena = Arena.new
            new_arena.user1_id = current_invite.from_id.to_i
            new_arena.user2_id = current_invite.to_id.to_i
            new_arena.save
        end
        render :json => {:success => current_invite}
    end

    def sent_requests()
        result = []
        for invite in Invite.where(:from_id => params[:my_id])
            corresponding_user = User.where(:id => invite.to_id)
            if corresponding_user.empty?
                # Commented out because Angular constantly polls this; polling
                # when there are no sent_requests is not an error
                # render :json => {:error => ERROR_MESSAGES[:not_exists]}
                return
            end
            corresponding_user = corresponding_user.first
            result.push({:username => corresponding_user.username, :from_id => invite.from_id, :to_id => invite.to_id, :status => invite.status})
        end
        render :json => result
    end
end
