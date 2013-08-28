json.array!(@users) do |user|
	json.user_id user.user_id
  	json.extract! user, :name, :email, :facebook_id, :status, :facebook_photo,:profile_photo, :photo_num, :age, :birthday, :startday, :job, :eye_color, :hair_color, :height,  :sex_interest, :sex_gender, :preferences, :premium
end
