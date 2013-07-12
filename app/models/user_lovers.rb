class UserLovers < ActiveRecord::Base

	belongs_to :lovers
	belongs_to :users

end
