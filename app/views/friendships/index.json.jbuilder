json.(@user, :user_id)
json.friendships (@friendships) do |friendship|
  json.extract! friendship, :friend_id, :accepted, :pending, :secret_lover_ask, :secret_lover_accepted
end