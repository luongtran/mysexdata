ActiveAdmin.register Friendship do

index do
  column "User", :user
  column "Friend", :friend
  column "Is Accepted?", :accepted
  column "Is Pending?", :pending
  column "Ask to see secret lovers", :secret_lover_ask
  column "Can see secret lovers?", :secret_lover_accepted
  column "Banned?", :banned


  default_actions

end

 action_item :only => :show do
  @friend = Friendship.find(params[:id])
    unless @friend.blocked
      link_to("Unlock!", controller.lock(@friend.user_id, @friend.friend_id))
    else
      link_to("Lock!", controller.lock(@friend.user_id, @friend.friend_id))
    end


  end

  controller do
    def lock(user, friend)
      @friendship = Friendship.where(user_id: user, friend_id: friend).first
      unless @friendship.nil?
        @friendship.banned = !@friendship.banned
        @friendship.save!
      end
      return "/admin/friendships/#{@friendship.id}"
    end
  end


end
