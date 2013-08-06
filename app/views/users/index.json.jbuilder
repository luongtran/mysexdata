json.array!(@users) do |user|
	json.user_id user.user_id
  	json.extract! user, :name, :email, :facebook_id, :status, :main_photo_url, :photo_num, :age, :startday, :job, :eye_color, :hair_color, :height,  :sex_interest, :sex_gender, :preferences
end
