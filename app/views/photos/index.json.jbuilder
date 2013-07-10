json.array!(@photos) do |photo|
  json.extract! photo, :user_id, :photo_id, :photo_url, :profile_photo
  json.url photo_url(photo, format: :json)
end