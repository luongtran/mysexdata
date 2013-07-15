json.(@user, :user_id)
json.(@friendships, :friend_id, :accepted, :pending, :secret_lover_ask, :secret_lover_accepted)
if @frienships.secret_lover_accepted
json.user_id @friendships.user_id
json.(@friend, :name, :lovers_num, :sex_interest, :age, :startday, :eye_color, :hair_color, :height, :hairdressing, :preferences)
end
json.lovers (@lovers) do |json, lover|
	json.extract! (lover, :lover_id, :name, :photo_url, :visibility)
end

json.messages (@messages) do |json, message|
	json.extract! (message, :sender_user_id, :status, :messages_num)
end
