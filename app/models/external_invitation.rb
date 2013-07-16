class ExternalInvitation < ActiveRecord::Base

	belongs_to :user

	validates :receiver, uniqueness: { case_sensitive: false}
	
end
