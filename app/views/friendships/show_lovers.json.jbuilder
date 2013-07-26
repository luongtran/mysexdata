json.user_id @user.user_id
json.friend_id @friend.id
json.lovers do
	json.public(@public_lovers) do |json, public_lover|
    	json.extract! public_lover, :lover_id, :name, :photo_url
    end
    json.secret(@secret_lovers) do |json, secret_lover|
    	json.extract! secret_lover, :lover_id, :name, :photo_url
    end
end