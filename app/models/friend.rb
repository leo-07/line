class Friend < ActiveRecord::Base
	belongs_to :friend,class_name: "User",foreign_key: :friend_id
	belongs_to :talk,class_name: "Talk",foreign_key: :talk_id
end
