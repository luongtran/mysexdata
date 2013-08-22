json.(@user, :user_id)
json.friendships (@friendships) do |friendship|
  json.extract! friendship, :user_id, :name, :profile_photo
end
