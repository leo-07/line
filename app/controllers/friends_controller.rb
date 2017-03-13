class FriendsController < ApplicationController
	before_action :move_to_index,only: [:index,:new,:create]

	def index
		@friends = current_user.user_friends
		@talk = Talk.new
	end

	def new
	end

	def show
		@friend = User.find(params[:id])
		@timelines = Timeline.where(user_id:@friend.id).order(updated_at: :desc)
	end

	def result
		@friends = Friend.new
		if User.find_by(email:result_params[:mail_address]).present?
			@friend_info = User.find_by(email:result_params[:mail_address])
		else
			redirect_to action: :new
		end
	end

	def create
		unless current_user.email == create_params[:mail_address]
			friend_info = User.find_by(email:create_params[:mail_address])
		    friend = Friend.where(user_id:create_params[:user_id],friend_id:friend_info.id).first_or_initialize
		    friend.save
		    redirect_to action: :index
		else
			redirect_to action: :new
		end
	end

	def destroy
		friend = Friend.find(params[:id])
		friend.destroy
		redirect_to action: :index
	end

	def move_to_index
  		redirect_to  new_user_session_path unless user_signed_in?
  	end

	private

	def result_params
		params.permit(:mail_address).merge(user_id:current_user.id)
	end

	def create_params
		params.require(:friend).permit(:mail_address).merge(user_id:current_user.id)
	end
end
