json.(@user, :user_id)
json.friendships(@users) do |myfriend|
  json.extract! myfriend, :user_id, :name, :profile_photo
end
