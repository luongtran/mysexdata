json.user_id @user.user_id
json.lovers do
  json.pending(@pending_lovers) do |json, pending_lover|
      json.extract! pending_lover, :lover_id, :name, :photo_url, :account_user
    end
end
