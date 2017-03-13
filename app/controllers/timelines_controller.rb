class TimelinesController < ApplicationController
	def index
		user_friends = current_user.friends
		@timelines = Timeline.where("user_id IN (?) OR user_id = ?", user_friends.ids, current_user.id).order(updated_at: :desc)
	end

	def create
		Timeline.create(create_params)
		redirect_to action: :index
	end

	def new
		@timeline = Timeline.new
	end

	def edit
		@timeline = Timeline.find(params[:id])
	end

	def destroy
		timeline = Timeline.find(params[:id])
		timeline.destroy
		redirect_to action: :index
	end

	def update
		timeline = Timeline.find(params[:id])
		timeline.update(text:update_params[:text])
		redirect_to action: :index
	end

	private
	def create_params
		params.require(:timeline).permit(:text).merge(user_id:current_user.id)
	end

	def update_params
		params.require(:timeline).permit(:text)
	end
end
