class Timeline < ActiveRecord::Base
	self.primary_key = :user_id
	belongs_to :user
	self.primary_key = :id
end
