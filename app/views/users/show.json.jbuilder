json.user_id @user.user_id
json.(@user, :name, :email, :facebook_id, :status, :main_photo_url, :photo_num, :job, :age, :startday, :eye_color, :hair_color, :height, :hairdressing, :sex_interest, :sex_gender, :preferences)

json.lovers do
	json.public(@public_lovers) do |json, public_lover|
    	json.extract! public_lover, :lover_id, :name, :photo_url
    end
    json.secret(@secret_lovers) do |json, secret_lover|
     	json.extract! secret_lover, :lover_id, :name, :photo_url
    end
end
