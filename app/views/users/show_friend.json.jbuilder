json.array!(@users) do |user|
  json.extract! user, :name, :email, :facebook_id, :password, :photo_num, :age, :startday, :job, :eye_color, :hair_color, :height,  :sex_interest, :sex_gender, :preferences
  json.url user_url(user, format: :json)
end