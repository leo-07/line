class Talk < ActiveRecord::Base
	self.primary_key = :friend_id
	belongs_to	:friend,class_name: "User"
	self.primary_key = :user_id
	belongs_to	:user,class_name: "User"
	self.primary_key = :id
	has_many	:comments,class_name:"Comment",foreign_key: :talk_id
end