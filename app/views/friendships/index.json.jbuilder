json.(@user, :user_id)
json.friendships(@users) do |myfriend|
  json.extract! myfriend, :user_id, :name, :profile_photo
  if myfriend.profile_photo == -1
    json.extract! myfriend, :facebook_photo
  end
end
