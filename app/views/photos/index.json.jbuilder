json.array!(@photos) do |photo|
  json.extract! photo, :photo_id, :photo_url
  json.url photo_url(photo, format: :json)
end