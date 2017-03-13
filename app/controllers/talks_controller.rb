class TalksController < ApplicationController
	def index
		@talks = Talk.where("(user_id = ? ) OR (friend_id = ?)",current_user.id,current_user.id).order(updated_at: :desc)
	end

	def show
		@talk = Talk.find(params[:id])
		@friend_is = (Friend.find_by_friend_id_and_user_id(@talk.user_id,current_user.id).present? || Friend.find_by_friend_id_and_user_id(@talk.friend_id,current_user.id).present?)
		@comment_create = Comment.new
		@friends = Friend.new
		@comments = Comment.where(talk_id:@talk.id).order(updated_at: :desc)

	end

	def create
		talk_user = Talk.find_by_user_id_and_friend_id(params_create[:user_id],params_create[:friend_id])
		talk_friend = Talk.find_by_friend_id_and_user_id(params_create[:user_id],params_create[:friend_id])

		unless (talk_friend.present?) || (talk_user.present?)
			talk_user = Talk.create(user_id:params_create[:user_id],friend_id:params_create[:friend_id])
			redirect_to talk_path(talk_user)
		else
			if talk_friend.present?
				redirect_to talk_path(talk_friend)
			else
				redirect_to talk_path(talk_user)
			end
		end
	end

	def destroy
		Talk.find(params[:id]).destroy
		Comment.where(talk_id:params[:id]).delete_all
		redirect_to action: :index
	end

	private
	def params_create
		params.require(:talk).permit(:friend_id).merge(user_id:current_user.id)
	end
end
