class CurrentUsersController < ApplicationController

  def show
    render json: User.find(currentUserId)
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

end