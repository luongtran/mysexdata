json.(@user, :user_id)
json.friendships (@friendships) do |friendship|
  json.extract! friendship, :user_id, :name, :profile_photo
  json.extract! friendship, :facebook_photo   if friendship.profile_photo == -1
end
