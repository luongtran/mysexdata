json.(@user, :user_id)
json.user_id @friendships.user_id

json.friend do
	json.(@friend, :user_id,:name, :sex_interest, :age, :startday, :eye_color, :hair_color, :height, :hairdressing, :preferences)
     json.lovers_num @lovers_num

	json.lovers do
		json.public(@public_lovers) do |json, public_lover|
    		json.extract! public_lover, :lover_id, :name, :photo_url
    	end
    	json.secret(@secret_lovers) do |json, secret_lover|
     		json.extract! secret_lover, :lover_id, :name, :photo_url
    	end
	end

	json.messages(@messages) do |json, message|
		json.extract! message, :sender_id, receiver_id, :content
	end

end




