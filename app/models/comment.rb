class Comment < ActiveRecord::Base
	self.primary_key = :talk_id
	belongs_to	:user_talk,class_name:"Talk"
end
