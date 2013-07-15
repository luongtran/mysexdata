class Experience < ActiveRecord::Base
  belongs_to :lover

  self.primary_key = "experience_id"

end
