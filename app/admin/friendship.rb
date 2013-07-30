ActiveAdmin.register Friendship do

index do
  column "User", :user
  column "Friend", :friend
  column "Is Accepted?", :accepted
  column "Is Pending?", :pending
  column "Ask to see secret lovers", :secret_lover_ask
  column "Can see secret lovers?", :secret_lover_accepted


  default_actions

end

 action_item :only => :show do
  logger.debug params
  @friend = Friendship.find(params[:id])
    logger.debug @friend.user_id
    logger.debug @friend.blocked
    link_to("Lock!", controller.lock(@friend.user_id, @friend.friend_id))
    link_to("Unlock!", controller.lock(@friend.user_id, @friend.friend_id)) if @friend.blocked == true

  end

  controller do
    def lock(user, friend)
      @friendship = Friendship.where(user_id: user, friend_id: friend).first
      unless @friendship.nil?
        logger.debug @friendship.blocked.nil?
        logger.debug !@friendship.blocked
        @friendship.blocked = !@friendship.blocked
        logger.debug "SJDA"
        logger.debug @friendship.blocked
        @friendship.save!
      end
      return '/admin/friendships'
    end
  end


end
