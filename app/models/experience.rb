class Experience < ActiveRecord::Base
  belongs_to :lover

  self.primary_key = "experience_id"



  validates :date, presence: false
  validates :moment, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
  validates :location, presence: false, length: { maximum: 140 }
  validates :place, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9 }
  validates :detail_one, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
  validates :detail_two, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
  validates :detail_three, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
  validates :hairdressing, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :kiss, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :oral_sex, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :intercourse, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :caresses, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :anal_sex, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :post_intercourse, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  validates :repeat, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :visibility, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :times, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :msd_score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :final_score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :personal_score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

end
