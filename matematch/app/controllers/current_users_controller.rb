class CurrentUsersController < ApplicationController

	def show
		render json: User.find(1)
	end

end