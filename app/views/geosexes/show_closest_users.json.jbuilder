json.extract! @geosex, :user_id, :lat, :lng, :address
json.closest_users(@nearby_users) do |json, nearby_user|
    json.extract! nearby_user, :user_id, :name, :status, :profile_photo
    json.extract! nearby_user, :facebook_photo   if nearby_user.profile_photo == -1
end
