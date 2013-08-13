json.user_id @user.id
json.(@user, :name, :email, :facebook_id, :status, :main_photo_url, :photo_num, :job, :age, :birthday, :startday, :eye_color, :hair_color, :height, :hairdressing, :sex_interest, :sex_gender, :preferences)
json.remember_token @user.remember_token
