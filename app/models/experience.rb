class Experience < ActiveRecord::Base
  belongs_to :lover

  self.primary_key = "experience_id"

  validates :msd_score, presence: true
  validates :final_score, presence: true
  validates :personal_score, presence: true

end
