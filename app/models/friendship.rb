class Friendship < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :friend, class_name: "User"

  scope :accepted_scope, ->{ where(accepted: true)}

  validates :user_id, presence: true
  validates :friend_id, presence: true

end
