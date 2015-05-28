class CurrentUsersController < ApplicationController

  def show
    render json: User.find(currentUserId)
  end
end