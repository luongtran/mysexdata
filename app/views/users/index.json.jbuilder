json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :facebook_id, :main_photo_url, :photo_num, :birthday, :startday, :job, :eye_color, :hair_color, :height,  :sex_interest, :sex_gender, :preferences
  json.url user_url(user, format: :json)
end