class Lover < ActiveRecord::Base

  #attr: facebook_id, name, photo_url, age, sex_gender, job, height, account_user 

  has_many :user_lovers, foreign_key: "lover_id", dependent: :destroy
  has_many :users, through: :user_lovers

  self.primary_key = "lover_id"

  has_many :lover_experiences, foreign_key: "lover_id", dependent: :destroy
  has_many :experiences, through: :lover_experiences, dependent: :destroy
  
  belongs_to :user_account, :class_name => "User"

  default_scope -> { order('name DESC')}

  scope :visible, -> { where(visibility: 0)}
  scope :secret, -> { where(visibility: 1)}

  validates :name, presence: true, length: { maximum: 70 }
  validates :photo_url, presence: true
  validates :facebook_id, presence: true, uniqueness: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :sex_gender, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :job, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
  validates :height, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
end
