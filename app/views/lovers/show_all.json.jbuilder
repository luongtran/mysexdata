json.user_id @user.id
json.name @user.name
json.email @user.email
json.lovers (@lovers) do |json, lover|
json.extract! lover , :lover_id, :facebook_id, :name, :photo_url, :photo_id, :age, :sex_gender, :job, :height, :visibility, :pending, :experience_id, :created_at, :updated_at
end