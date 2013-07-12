json.user_id @user.id
json.(@user, :name, :email, :facebook_id, :main_photo_url, :photo_num, :job, :age, :startday, :eye_color, :hair_color, :height, :hairdressing, :sex_interest, :sex_gender, :preferences)

json.lovers do
	json.public(@public_lovers) do |json, public_lover|
    	json.extract! public_lover, :id, :name, :photo_url, :pending
    end
    json.secret(@secret_lovers) do |json, secret_lover|
    	json.extract! secret_lover, :id, :name, :photo_url, :pending
    end
end
