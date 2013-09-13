json.user_id @user.user_id
json.lovers do
  json.public(@public_lovers) do |json, public_lover|
      json.extract! public_lover, :lover_id, :name, :photo_url, :age, :sex_gender, :job, :height, :account_user
      rel = public_lover.user_lovers.where(user_id: @user.user_id).first
      json.pending rel.pending
    end
    json.secret(@secret_lovers) do |json, secret_lover|
      json.extract! secret_lover, :lover_id, :name, :photo_url, :age, :sex_gender, :job, :height, :account_user
      rel = secret_lover.user_lovers.where(user_id: @user.user_id).first
      json.pending rel.pending
    end
end
