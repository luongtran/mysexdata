json.user_id @user.id
json.friendship_id @friendship.id
json.extract! @lover ,:lover_id, :facebook_id, :name, :photo_url, :age, :sex_gender, :job, :height, :visibility, :pending, :experience_id, :created_at, :updated_at