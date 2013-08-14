class Message < ActiveRecord::Base
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"

  validates :receiver_id, presence: true
  validates :sender_id, presence: true
  validates :content, presence: true, length: { maximum: 160 }
  validate :limit_messages, on: :create

  private

    def limit_messages
      if self.receiver.messages(:reload).count >= 20
        errors.add(:base, "exceeded message limit")
        return false
      end
      return true
    end
end
