class User < ActiveRecord::Base
  #Encrypt password in database  
  has_secure_password

  self.primary_key = "user_id"

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create :create_geosex

  

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
  has_many :friends, through: :friendships, source: :friend, conditions: ["friendships.accepted = ?", true], select: 'users.user_id as friend_id'
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

  def make_friend!(other_user)
    friendships.create!(friend_id: other_user.user_id)
  end

  def receive_message!(other_user,content)
    messages.create!(sender_id: other_user.user_id, content: content)
  end

  def unmake_friend!(other_user)
    friendships.find_by(friend_id: other_user.user_id).destroy
    friendships.find_by(user_id: other_user.user_id).destroy
  end

  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    save_without_validation
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    #def create_geosex
    #  self.build_geosex
    #end



end
