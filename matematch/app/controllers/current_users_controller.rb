class CurrentUsersController < ApplicationController
  # skip_before_action :authenticate, only: [:show]

  def show
    render json: User.find(currentUserId)
  end
end