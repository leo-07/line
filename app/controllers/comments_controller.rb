class CommentsController < ApplicationController
	def create
		Comment.create(create_params)
		redirect_to :back
	end

	private
	def create_params
		params.require(:comment).permit(:comment,:talk_id).merge(user_id:current_user.id)
	end
end
