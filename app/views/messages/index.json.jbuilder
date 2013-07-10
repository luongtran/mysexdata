json.array!(@messages) do |message|
  user = User.find(message.sender_id)
  json.extract! message, :receiver_id, :sender_id, :created_at
  json.extract! user, :id, :name
end