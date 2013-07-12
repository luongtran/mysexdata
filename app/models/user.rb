class User < ActiveRecord::Base
  #Encrypt password in database  
  has_secure_password

  self.primary_key = "user_id"

  before_save { self.email = email.downcase }
  before_save :create_remember_token
  before_create :create_geosex

  has_many :photos, dependent: :destroy
  has_and_belongs_to_many :lovers
  has_many :friendships
  has_many :user_photos
  has_many :photos, through: :user_photos
  has_many :messages, through: :user_messages

  #has_many :friendships, foreign_key: "user_id", dependent: :destroy
  #has_many :friends, through: :friendships, source: :friend, conditions: ["friendships.accepted = ?", true], select: 'users.*, friendships.secret_lover_accepted as has_secret_access'
  #has_many :pending_friends, through: :friendships, source: :friend, conditions: ["friendships.pending = ?", true]
  #has_many :secret_petitions, through: :friendships, source: :friend, conditions: ["friendships.secret_lover_ask = ?", true]
  has_many :messages, foreign_key: "receiver_id", dependent: :destroy

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
    friendships.accepted_scope.find_by(friend_id: other_user.id )

  end

  def make_friend!(other_user)
    friendships.create!(friend_id: other_user.id)
  end

  def receive_message!(other_user,content)
    messages.create!(sender_id: other_user.id, content: content)
  end

  def unmake_friend!(other_user)
    friendships.find_by(friend_id: other_user.id).destroy
    friendships.find_by(user_id: other_user.id).destroy
  end

  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    save_without_validation
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_geosex
      self.build_geosex
    end



end
