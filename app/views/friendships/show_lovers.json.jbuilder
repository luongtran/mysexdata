json.user_id @user.id
json.friendship_id @friendship.id
json.lovers (@lovers) do |json, lover|
	json.extract! lover ,:lover_id, :facebook_id, :name, :photo_url, :age, :sex_gender, :job, :height, :visibility, :pending, :created_at, :updated_at
end