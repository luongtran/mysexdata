class Experience < ActiveRecord::Base
  belongs_to :lover

  validates :lover_id, presence: true
end
