json.user_id @user.user_id
json.friend_id @friend.id

json.lover do 
	json.(@lover ,:lover_id, :facebook_id, :name, :photo_url)
	json.experiences (@experiences) do |json, experience|
		json.(experience, :experience_id,:final_score)
	end
end

