json.user_id @user.user_id
json.friendship_id @friendship.id
json.extract! @lover ,:lover_id, :facebook_id, :name, :photo_url, :age, :sex_gender, :job, :height, :visibility, :pending,  :created_at, :updated_at