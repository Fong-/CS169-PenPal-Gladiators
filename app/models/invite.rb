class Invite < ActiveRecord::Base
    belongs_to :from, :class_name => "User", :foreign_key => "from_id"
    belongs_to :to, :class_name => "User", :foreign_key => "to_id"
    attr_accessible :from, :to

    def self.did_create_new_invite(from_user, to_user)
        if !Invite.should_allow_user_to_send_invite from_user, to_user
            return false
        end
        Invite.create :from => from_user, :to => to_user
        return true
    end

    def self.all_users_invited_by(user)
        return Invite.find_all_by_from_id(user.id).map(&:to)
    end

    def self.all_users_inviting(user)
        return Invite.find_all_by_to_id(user.id).map(&:from)
    end

    def self.pending_invite(from_user, to_user)
        return Invite.find_by_from_id_and_to_id(from_user.id, to_user.id)
    end

    def accept
        Arena.create :user1 => from, :user2 => to
        destroy
    end

    def reject
        # TODO Should we blacklist the rejectee from future invites?
        destroy
    end

    private
    def self.should_allow_user_to_send_invite(from_user, to_user)
        return from_user.id != to_user.id &&
            Arena.where("user1_id = :a AND user2_id = :b OR user1_id = :b AND user2_id = :a", :a => from_user.id, :b => to_user.id).empty? &&
            Invite.pending_invite(from_user, to_user).nil?
    end
end
