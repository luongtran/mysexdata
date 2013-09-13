json.extract! @message, :receiver_id, :sender_id, :content, :created_at, :unread
json.extract! @user, :user_id, :name
