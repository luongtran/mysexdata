class Lover < ActiveRecord::Base
  belongs_to :user
  before_create :create_experience

  has_one :experience, dependent: :destroy

  default_scope -> { order('name DESC')}

  scope :visible, -> { where(visibility: 0)}
  scope :secret, -> { where(visibility: 1)}

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 70 }
  validates :facebook_id, presence: true

  def create_experience
    self.build_experience
  end
end
