class Lover < ActiveRecord::Base
  
  has_and_belongs_to_many :lovers

  before_create :create_experience

  self.primary_key = "lover_id"

  has_one :experience, dependent: :destroy

  default_scope -> { order('name DESC')}

  scope :visible, -> { where(visibility: 0)}
  scope :secret, -> { where(visibility: 1)}

  validates :name, presence: true, length: { maximum: 70 }
  validates :facebook_id, presence: true

  def create_experience
    self.build_experience
  end
end
