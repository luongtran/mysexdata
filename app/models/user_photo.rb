class UserPhoto < ActiveRecord::Base

	belongs_to :photo
	belongs_to :user
	
end
