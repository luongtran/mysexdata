json.friendships (@friendships) do |friendship|
  json.extract! friendship, :user_id, :friend_id, :accepted, :pending, :secret_lover_ask, :secret_lover_accepted
end