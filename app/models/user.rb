class User < ActiveRecord::Base
  #Encrypt password in database
  has_secure_password

  self.primary_key = "user_id"

  before_save { self.email = email.downcase }
  before_create :create_remember_token



  # Lovers
  has_many :user_lovers, foreign_key: "user_id", dependent: :destroy
  has_many :secret_lovers, through: :user_lovers, source: :lover, conditions: ["user_lovers.visibility = ?", 0]
  has_many :public_lovers, through: :user_lovers, source: :lover, conditions: ["user_lovers.visibility = ?", 1]
  has_many :non_pending_lovers, through: :user_lovers, source: :lover, conditions: ["user_lovers.pending = ?", false]
  has_many :pending_lovers, through: :user_lovers, source: :lover, conditions: ["user_lovers.pending = ?", true]
  has_many :lovers, through: :user_lovers

  # Photos
  has_many :user_photos
  has_many :photos, through: :user_photos, dependent: :destroy

  # Messages
  has_many :messages, foreign_key: "receiver_id", dependent: :destroy


  # Friendships
  has_many :friendships, foreign_key: "user_id", dependent: :destroy
  has_many :friends, through: :friendships, source: :friend, conditions: ["friendships.accepted = ?", true], select: 'users.user_id as friend_id '
  has_many :pending_friends, through: :friendships, source: :friend, conditions: ["friendships.pending = ?", true], select: 'users.user_id as friend_id'
  has_many :secret_petitions, through: :friendships, source: :friend, conditions: ["friendships.secret_lover_ask = ? AND friendships.accepted = ?", true, true], select: 'users.user_id as friend_id'

  # Requests
  has_many :external_invitations,foreign_key: "sender_id", dependent: :destroy

  # Geosex
  has_one :geosex, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_DATE_REGEX = /\d{2}+\/\d{2}+\/\d{4}/

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates :facebook_id, presence: true, uniqueness: { case_sensitive: false}
  validates :status, presence: true
  validates :main_photo_url, presence: true
  validates :photo_num, presence: true
  validates :age, presence: true
  validates :startday, presence: true
  validates :eye_color, presence: true
  validates :hair_color, presence: true
  validates :job, presence:true
  validates :height, presence: true
  validates :sex_interest, presence: true
  validates :sex_gender, presence: true
  validates :hairdressing, presence: true
  validates :password_confirmation, length: { maximum: 4 }
  validates :password, length: { maximum: 4 }
  validates :preferences, presence: true

  def friends?(other_user)
    friendships.accepted_scope.find_by(friend_id: other_user.user_id )

  end

  def invite_friend!(other_user)
    # Create a friendship between the user that sends the invitation and receiver with accepted = false (default).
    friendships.create!(friend_id: other_user.user_id)

    # Creating the reverse relationship with pending = true.
    other_user.friendships.create!(friend_id: self.user_id, pending: true)
  end

  def invite_email_friend!(user, email)
    if UserMailer.invitation_email(user, email).deliver
      external_invitations.create!(receiver: email)
      return true
    else
      return false
    end
  end

  def add_facebook_friend!(friend)
     external_invitations.create!(name: friend[:name],facebook_id: friend[:facebook_id],photo_url: friend[:photo_url])
  end

  def accept_friend!(other_user)
    friendship = friendships.where(friend_id: other_user.user_id).first
    reverse_friendship = other_user.friendships.where(friend_id: self.user_id).first
    if friendship.nil?
      return render json: {exception: "UserException", message: "This user is not invited to be your friend"}
    end
    friendship.update_attributes!(accepted: true,pending: false) and reverse_friendship.update_attributes!(accepted: true,pending: false)
  end

  def omit_friend!(other_user)
    friendships.where(friend_id: other_user.user_id).first.destroy
    other_user.friendships.where(friend_id: self.user_id).first.destroy
  end

  def invite_secret_friend!(other_user)
    friendship = other_user.friendships.where(friend_id: self.user_id).first
    friendship.update_attributes(secret_lover_ask: true)
  end

  def accept_secret_friend!(other_user)
    friendship2 = other_user.friendships.where(friend_id: self.user_id).first
    friendship = friendships.where(friend_id: other_user.user_id).first
    friendship.update_attributes(secret_lover_ask: false) and friendship2.update_attributes(secret_lover_accepted: true)

  end

  def omit_secret_friend!(other_user)
    friendship = friendships.where(friend_id: other_user.user_id).first
    if friendship.update_attribute(:secret_lover_ask, false)
      return true
    else
      return false
    end
  end

  def send_message!(receiver, content)
    messages.create!(sender_id: receiver.user_id, content: content)
  end


  def receive_message!(sender,content)
    messages.create!(sender_id: sender.user_id, content: content)
  end

  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    save_without_validation
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
