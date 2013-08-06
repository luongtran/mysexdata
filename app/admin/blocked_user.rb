ActiveAdmin.register BlockedUser do


index do
  column 'User', :user, sortable: true
  column 'BlockedUser' ,:blocked_user
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

   controller do
     def permitted_params
       params.permit(:blocked_user => [:user_id, :blocked_user_id, :blocked, :description])
     end
    end

end
