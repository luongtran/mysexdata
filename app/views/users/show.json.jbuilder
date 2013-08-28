json.user_id @user.id
json.(@user, :name, :email, :facebook_id, :status, :facebook_photo, :profile_photo, :photo_num, :job, :age, :birthday, :startday, :eye_color, :hair_color, :height, :hairdressing, :sex_interest, :sex_gender, :preferences,:premium)

json.lovers do
	json.public(@public_lovers) do |json, public_lover|
    	json.extract! public_lover, :lover_id, :name, :photo_url
    end
    json.secret(@secret_lovers) do |json, secret_lover|
     	json.extract! secret_lover, :lover_id, :name, :photo_url
    end
end
