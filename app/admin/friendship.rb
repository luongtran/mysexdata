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
  @friend = Friendship.find(params[:id])
    link_to("Block!") if @friend.blocked?
    link_to("Block!") if !@friend.blocked?
  end

end
