json.(@user, :id, :name, :email, :facebook_id, :main_photo_url, :photo_num, :job, :birthday, :startday, :eye_color, :hair_color, :height, :hairdressing, :sex_interest, :sex_gender, :preferences)
json.lovers(@lovers) do |json, lover|
    json.extract! lover, :id, :name, :photo_url, :visibility, :pending
end