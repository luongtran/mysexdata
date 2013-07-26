json.user_id @user.user_id
json.photos(@photos) do |photo|
  json.extract! photo, :photo_id, :url
  json.date photo.created_at
end
