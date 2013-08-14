json.extract! @geosex, :user_id, :lat, :lng, :address
json.closest_users(@nearby_users) do |json, nearby_user|
	json.extract! nearby_user, :user_id, :name, :status, :profile_photo
end
