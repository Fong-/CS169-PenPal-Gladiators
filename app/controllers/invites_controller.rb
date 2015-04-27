class InvitesController < ApplicationController

    SUCCESS_MESSAGES = {
        :create_success => "successfully invited user",
        :accept_or_reject_success => "successfully submitted decision"
    }

    def outgoing
        extract_arguments_from_params
        render :json => { :outgoing => Invite.all_users_invited_by(@me).map(&:response_object) }
    end

    def incoming
        extract_arguments_from_params
        render :json => { :incoming => Invite.all_users_inviting(@me).map(&:response_object) }
    end

    def invite
        if !extract_arguments_from_params(:to_user)
            render_error :resource_not_found and return
        end
        if Invite.did_create_new_invite @me, @to_user
            render :json => { :success => SUCCESS_MESSAGES[:create_success] }
        else
            render_error :cannot_invite
        end
    end

    def accept
        accept_or_reject_invitation :accept
    end

    def reject
        accept_or_reject_invitation :reject
    end

    def accept_or_reject_invitation(decision)
        if !extract_arguments_from_params(:from_user)
            render_error :resource_not_found and return
        end
        invite = Invite.pending_invite @from_user, @me
        if invite.present?
            decision == :accept ? invite.accept : invite.reject
            render :json => { :success => SUCCESS_MESSAGES[:accept_or_reject_success] }
        else
            render_error :cannot_accept_or_reject
        end
    end

    def extract_arguments_from_params(*param_keys)
        for key in param_keys
            if params[key].nil?
                return false
            end
            other_user = User.find_by_id params[key]
            if other_user.present?
                instance_variable_set "@#{key}", other_user
            else
                return false
            end
        end
        @me = @token_results[:user]
        return @me.present?
    end
end
