ActiveAdmin.register BlockedUser do


index do
  column 'User', :user_id, sortable: true
  column 'BlockedUser' ,:blocked_user_id
  column :blocked
  column :description

  default_actions
end

show do |ad|
      attributes_table do
        row :user, sortable: 'user.name'
        row :blocked_user
        row :blocked
        row :description
      end
end

 # action_item :only => :show do
 #  @bUser = BlockedUser.find(params[:id])
 #    unless @bUser.blocked
 #      link_to("Unlock!", controller.lock(@bUser.user1_id, @bUser.user2_id))
 #    else
 #      link_to("Lock!", controller.lock(@bUser.user1_id, @bUser.user2_id))
 #    end


 #  end

   controller do
     def permitted_params
       params.permit(:blocked_user => [:user_id, :blocked_user_id, :blocked, :description])
     end
    end
 #    def lock(user, user2)
 #      @rel = BlockedUser.where(user1_id: user, user2_id: user2).first
 #      unless @rel.nil?
 #        @rel.blocked = !@rel.blocked
 #        @rel.save!
 #      end
 #      return "/admin/blocked_user/#{@rel.id}"
 #    end
 #  end

end
