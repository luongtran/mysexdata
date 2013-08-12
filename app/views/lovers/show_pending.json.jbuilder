json.user_id @user.user_id
json.lovers do
  json.public(@public_lovers) do |json, public_lover|
      json.extract! public_lover, :lover_id, :name, :photo_url
    end
end
