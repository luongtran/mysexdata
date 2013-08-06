module UsersHelper

  def is_blocked(sender, receiver)
      @blockers = BlockedUser.where(user_id: @user.user_id, blocked_user_id: receiver.user_id).first
      if !@blockers.nil?
        return @blockers.blocked
      end
      return false
    end
end
