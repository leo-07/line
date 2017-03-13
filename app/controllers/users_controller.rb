class UsersController < ApplicationController
	def show
    @timelines = Timeline.where(user_id:current_user.id).order(updated_at: :desc)
	end

	def edit
	end

	def update
    	current_user.update(update_params)
      redirect_to controller:'friends',action:'index'
  end

  	private
  	def update_params
    	params.require(:user).permit(:nickname,:avatar)
    end
  end
