json.(@user, :user_id)
json.friendships (@friendships) do |friendship|
  json.extract! friendship, :friend_id, :name, :profile_photo
end
