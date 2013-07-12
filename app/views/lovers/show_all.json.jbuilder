json.user_id @user.id
json.lovers do
	json.public(@public_lovers) do |json, public_lover|
    	json.extract! public_lover, :id, :name, :photo_url, :age, :sex_gender, :job, :height, :experience_id, :pending
    end
    json.secret(@secret_lovers) do |json, secret_lover|
    	json.extract! secret_lover, :id, :name, :photo_url, :age, :sex_gender, :job, :height, :experience_id, :pending 
    end
end
