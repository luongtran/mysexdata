class Lover < ActiveRecord::Base
  
  has_many :users, through: :lover_users

  self.primary_key = "lover_id"

  has_many :lover_experiences
  has_many :experiences, through: :lover_experiences, dependent: :destroy

  default_scope -> { order('name DESC')}

  scope :visible, -> { where(visibility: 0)}
  scope :secret, -> { where(visibility: 1)}

  validates :name, presence: true, length: { maximum: 70 }
  validates :photo_url, presence: true
  validates :facebook_id, presence: true, uniqueness: { case_sensitive: false}

end
