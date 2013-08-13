json.(@user, :user_id)
json.friendships (@friendships) do |friendship|
  json.extract! friendship, :friend_id, :name, :main_photo_url
end
