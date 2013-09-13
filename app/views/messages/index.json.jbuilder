json.receiver_id @user.user_id
json.messages(@messages) do |message|
	json.extract! message, :sender_id, :content, :unread
	json.date message.created_at
end